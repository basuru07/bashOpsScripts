#!/bin/bash

# Clean and create output directory
rm -rf out
mkdir -p out/applications

# Temporary files
tmp_dir=$(mktemp -d)
merged_file="$tmp_dir/merged.yaml"
> "$merged_file"

# ===================================================================
# Step 1: Merge all fragments by metadata.name (deep merge with last win)
# ===================================================================
find src/applications -name "*.yaml" -o -name "*.yml" | sort | while read -r file; do
    # Skip invalid YAML files gracefully
    if ! yq eval '.' "$file" > /dev/null 2>&1; then
        continue
    fi

    # Extract the name (fallback to filename if missing)
    name=$(yq eval '.metadata.name // empty' "$file")
    if [[ -z "$name" ]]; then
        # Try to guess from filename
        name=$(basename "$file" | sed -E 's/(.*)[-_.].*/\1/' | sed -E 's/[^a-zA-Z0-9-]/-/g')
        [[ "$name" == "fragment" || "$name" == "app" ]] && name="app-$(date +%s)"
    fi

    temp_app_file="$tmp_dir/app-${name}.yaml"

    # If first time seeing this app, start fresh
    if [[ ! -f "$temp_app_file" ]]; then
        yq eval ".metadata.name = \"$name\" | .metadata.namespace //= \"argocd\"" "$file" > "$temp_app_file"
    fi

    # Deep merge: later fragments override earlier ones
    yq eval -i --argfile base "$temp_app_file" --argfile override "$file" \
        '$override * $base' "$temp_app_file"
done

# ===================================================================
# Step 2: Finalize applications + apply defaults + write to out/
# ===================================================================
for app_file in "$tmp_dir"/app-*.yaml; do
    [[ ! -f "$app_file" ]] && continue

    yq eval -i '
        .apiVersion //= "argoproj.io/v1alpha1" |
        .kind //= "Application" |
        .metadata.namespace //= "argocd" |
        .spec //= {} |
        .spec.project //= "default" |
        .spec.source //= {} |
        .spec.source.repoURL //= "https://github.com/placeholder/repo" |
        .spec.source.targetRevision //= "HEAD" |
        .spec.destination //= {} |
        .spec.destination.server //= "https://kubernetes.default.svc" |
        .spec.destination.namespace //= .metadata.name
    ' "$app_file"

    name=$(yq eval '.metadata.name' "$app_file")
    cp "$app_file" "out/applications/${name}.yaml"
done

# ===================================================================
# Step 3: Generate sync-waves.json
# ===================================================================
waves_file="$tmp_dir/waves.json"
echo '{"waves": {}}' > "$waves_file"

for app_file in out/applications/*.yaml; do
    [[ ! -f "$app_file" ]] && continue
    name=$(yq eval '.metadata.name' "$app_file")
    explicit_wave=$(yq eval '.metadata.annotations."argocd.argoproj.io/sync-wave" // empty' "$app_file")
    wave="2"  # default

    if [[ -n "$explicit_wave" ]]; then
        wave="$explicit_wave"
    elif [[ "$name" == *"database"* || "$name" == *"postgres"* || "$name" == *"redis"* || "$name" == *"infra"* ]]; then
        wave="0"
    elif [[ "$name" == *"backend"* || "$name" == *"api"* || "$name" == *"middleware"* ]]; then
        wave="1"
    fi

    # Add to JSON (jq way of appending to object)
    jq --arg w "$wave" --arg n "$name" '
        .waves[$w] //= [] |
        .waves[$w] += [$n] |
        .waves[$w] |= unique
    ' "$waves_file" > "$waves_file.tmp" && mv "$waves_file.tmp" "$waves_file"
done

# Sort keys for clean output
jq '.waves |= with_entries(.key |= tonumber) | .waves |= from_entries' "$waves_file" > out/sync-waves.json

# ===================================================================
# Step 4: Generate health-checks.json
# ===================================================================
echo '{"checks": []}' > out/health-checks.json

for app_file in out/applications/*.yaml; do
    [[ ! -f "$app_file" ]] && continue
    name=$(yq eval '.metadata.name' "$app_file")
    check=$(yq eval '.metadata.annotations."health.check" // empty' "$app_file")

    if [[ -n "$check" ]]; then
        jq --arg app "$name" --arg type "$check" '
            .checks += [{app: $app, type: $type}]
        ' out/health-checks.json > out/health-checks.json.tmp && mv out/health-checks.json.tmp out/health-checks.json
    fi
done

# ===================================================================
# Step 5: Generate sync-status.json
# ===================================================================
echo '{"total": 0, "applications": {}}' > out/sync-status.json

total=0
for app_file in out/applications/*.yaml; do
    [[ ! -f "$app_file" ]] && continue
    name=$(yq eval '.metadata.name' "$app_file")
    wave=$(yq eval '.metadata.annotations."argocd.argoproj.io/sync-wave" // "2"' "$app_file")
    creates_ns=$(yq eval '.spec.syncPolicy.syncOptions // [] | any(contains("CreateNamespace=true"))' "$app_file")

    entry=$(jq -n \
        --arg w "$wave" \
        --argjson creates "$creates_ns" \
        '{wave: ($w|tonumber), createsNamespace: $creates, healthy: true}')

    jq --arg n "$name" --argjson e "$entry" '
        .applications[$n] = $e
    ' out/sync-status.json > out/sync-status.json.tmp && mv out/sync-status.json.tmp out/sync-status.json

    ((total++))
done

jq --argjson t "$total" '.total = $t' out/sync-status.json > out/sync-status.json.tmp && mv out/sync-status.json.tmp out/sync-status.json

# Cleanup
rm -rf "$tmp_dir"

echo "All done! Outputs generated in ./out/"