#!/bin/bash
# This script show the oraganized files in a folder by file type

#!/bin/bash
mkdir -p TextFiles Images
for file in *; do
  if [[ $file == *.txt ]]; then
    mv "$file" TextFiles/
  elif [[ $file == *.jpg ]]; then
    mv "$file" Images/
  fi
done
