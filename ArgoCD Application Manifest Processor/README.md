# ArgoCD Application Manifest Processor

You are given a directory ```src/applications/ ```that contains fragmented, incomplete, or scattered ArgoCD Application YAML manifests (possibly split across multiple files, some missing fields, some with custom annotations).

Write a pure Bash script called execute.sh that processes all YAML files in ```src/applications/``` and generates the following outputs inside an ```out/``` directory

### How to run
```bash
chmod +x execute.sh
./execute.sh