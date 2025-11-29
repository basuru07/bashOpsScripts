# Echoes of the Heptagon

You are given a mysterious file: `src/echoes/pattern.csv`

This file contains exactly 1000 lines, each with a single integer (positive or negative) representing a signal wave.

## Your Task

Write a single Bash script `execute.sh` that:

* Reads the file `src/echoes/pattern.csv`
* Treats the 1000 numbers as a sequence (an array)
* Finds the longest palindromic subarray (contiguous subsequence) in this sequence
* Measures how long (in milliseconds) it took to find it
* Prints exactly this format:

```
PALINDROME_DURATION:XX.XXX
```

where `XX.XXX` is the execution time in milliseconds with exactly 3 decimal places

## Example Output

```
PALINDROME_DURATION:49.700
```

## Requirements

* Must read all 1000 integers from the CSV file
* A palindromic subarray reads the same forwards and backwards (e.g., `[1, 2, 3, 2, 1]`)
* Must find the longest such contiguous subsequence
* Execution time must be measured and reported in milliseconds
* Time must be formatted with exactly 3 decimal places
* Output format is strict — no extra text, spaces, or newlines