# CSV Aggregation Script 

## Overview
This guide provides a pure Bash script that reads a CSV file, groups by category, and sums amounts.

## Script: execute.sh

```bash
#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p out

# Initialize the output file with header
echo "category,total_amount" > out/result.csv

# Process the CSV: skip header, group by category, sum amounts
tail -n +2 src/data.csv | awk -F',' '
{
    category = $1
    amount = $2
    total[category] += amount
}
END {
    for (cat in total) {
        print cat "," total[cat]
    }
}
' | sort >> out/result.csv
```

## How It Works

**Step 1: Directory Setup**
- `mkdir -p out` creates the output directory if needed

**Step 2: Header Creation**
- Writes the header row to the output file

**Step 3: Data Processing**
- `tail -n +2` skips the header line of src/data.csv
- `awk -F','` processes comma-separated values
- Uses an associative array `total[category]` to accumulate amounts
- In the END block, iterates through all categories and prints results
- `sort` organizes output alphabetically by category

## Example Execution

**Input (src/data.csv):**
```
category,amount,quantity
A,100,5
B,200,3
A,150,2
B,300,4
A,50,1
```

**Output (out/result.csv):**
```
category,total_amount
A,300
B,500
```

## Usage

1. Save as `execute.sh`
2. Make executable: `chmod +x execute.sh`
3. Run: `./execute.sh`
4. Check results: `cat out/result.csv`

## Requirements

- Bash shell
- Standard Unix utilities: `mkdir`, `echo`, `tail`, `awk`, `sort`


### How to run
```bash
chmod +x execute.sh
./execute.sh