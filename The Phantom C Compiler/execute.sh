#!/bin/bash

# Create output directory
mkdir -p out

# Find the phantom.c file anywhere in the project
src=$(find . -name phantom.c -type f | head -n1)

# Compile it
gcc "$src" -o out/phantom 2>/dev/null || clang "$src" -o out/phantom 2>/dev/null || cc "$src" -o out/phantom

# On Windows (GitHub Actions Windows runner), rename to .exe if needed
[[ "$OS" == "Windows_NT" ]] || [[ -n "$RUNNER_OS" && "$RUNNER_OS" == "Windows" ]] && [[ -f out/phantom ]] && mv out/phantom out/phantom.exe