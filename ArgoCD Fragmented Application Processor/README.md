# ArgoCD Fragmented Application Processor 

You are given a folder `src/applications/` that contains zero or more (possibly incomplete, fragmented, or even malformed) ArgoCD Application YAML manifests.

Write exactly one Bash script called `execute.sh` that does the following:

## Required Outputs

Must be created in the `out/` directory:

1. **out/applications/** - A folder containing one complete, valid ArgoCD Application YAML file per application
   * All fragments with the same `metadata.name` must be merged (deep merge, last wins)
   * Missing required fields must be filled with sensible defaults
   * Output filename should be `<app-name>.yaml`

2. **out/sync-waves.json** - Automatically determine sync-wave ordering

## Example Output

```json
{
  "waves": {
    "0": ["database", "infra"],
    "1": ["backend"],
    "2": ["frontend"]
  }
}
```
