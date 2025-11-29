#!/bin/bash
rm -rf out && mkdir -p out/applications
tmp=$(mktemp -d)

# Step 1: Merge all fragments by metadata.name (using JSON as intermediate)
for f in src/applications/*.{yaml,yml} 2>/dev/null; do
  name=$(yq e '.metadata.name // ""' "$f" 2>/dev/null || continue)
  [[ -z "$name" || "$name" == "null" ]] && name=$(basename "$f" | cut -d. -f1)
  yq e -j '.' "$f" 2>/dev/null >> "$tmp/$name.json" || continue
done

# Step 2: Combine fragments + apply defaults → write final YAML
for json in "$tmp"/*.json; do
  [ -f "$json" ] || continue
  name=$(basename "$json" .json)
  < "$json" jq -s add > "$tmp/merged.json"
  
  yq e -P '
    .apiVersion //= "argoproj.io/v1alpha1" |
    .kind //= "Application" |
    .metadata.name = "'"$name"'" |
    .metadata.namespace //= "argocd" |
    .spec //= {} |
    .spec.project //= "default" |
    .spec.source //= {} |
    .spec.source.repoURL //= "https://github.com/placeholder/repo" |
    .spec.source.targetRevision //= "HEAD" |
    .spec.destination //= {server: "https://kubernetes.default.svc", namespace: .metadata.name}
  ' "$tmp/merged.json" > "out/applications/$name.yaml"
done

# Step 3: Generate sync-waves.json
jq -n '{waves:{}}' > out/sync-waves.json
for f in out/applications/*.yaml; do
  [ -f "$f" ] || continue
  name=$(yq e .metadata.name "$f")
  wave=$(yq e '.metadata.annotations."argocd.argoproj.io/sync-wave" // 
    (if (.spec.syncPolicy.syncOptions // [] | index("CreateNamespace=true")) or
        (.metadata.name | test("database|postgres|redis|infra")) then "0"
     elif (.metadata.name | test("backend|api|middleware")) then "1"
     else "2" end)' "$f")
  
  jq --arg w "$wave" --arg n "$name" '.waves[$w] += [$n]' out/sync-waves.json > "$tmp/tmp" && mv "$tmp/tmp" out/sync-waves.json
done
jq 'walk(if type == "array" then unique else . end)' out/sync-waves.json > "$tmp/tmp" && mv "$tmp/tmp" out/sync-waves.json

# Step 4: health-checks.json
jq -n '{checks:[]}' > out/health-checks.json
for f in out/applications/*.yaml; do
  check=$(yq e '.metadata.annotations."health.check" // empty' "$f")
  [[ "$check" == "null" || -z "$check" ]] || \
    jq --arg a "$(yq e .metadata.name "$f")" --arg t "$check" '.checks += [{app:$a, type:$t}]' \
      out/health-checks.json > "$tmp/tmp" && mv "$tmp/tmp" out/health-checks.json
done

# Step 5: sync-status.json
jq -n '{total:0, applications:{}}' > out/sync-status.json
for f in out/applications/*.yaml; do
  name=$(yq e .metadata.name "$f")
  wave=$(yq e '.metadata.annotations."argocd.argoproj.io/sync-wave" // "2"' "$f")
  ns=$(yq e '(.spec.syncPolicy.syncOptions // [] | contains(["CreateNamespace=true"]))' "$f")
  jq --arg n "$name" --arg w "$wave" --argjson ns "$ns" '
    .applications[$n] = {wave: ($w|tonumber), createsNamespace: $ns, healthy: true} |
    .total += 1
  ' out/sync-status.json > "$tmp/tmp" && mv "$tmp/tmp" out/sync-status.json
done

rm -rf "$tmp"