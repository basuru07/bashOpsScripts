#!/bin/bash
mkdir -p out
src=$(find . -name phantom.c -type f | head -n1)
gcc "$src" -o out/phantom 2>/dev/null || clang "$src" -o out/phantom 2>/dev/null || cc "$src" -o out/phantom