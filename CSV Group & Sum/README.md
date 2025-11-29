# Challenge: "CSV Group & Sum" – Pure Bash One-Liner

You are given a CSV file at: `src/data.csv`

It will always have this exact header and structure:

```csv
category,amount,quantity
```

## Your Task

Write a single Bash script named `execute.sh` that:

* Reads `src/data.csv`
* Groups all rows by the `category` column
* Calculates the sum of the `amount` column for each category
* Outputs a new CSV file at `out/result.csv` with exactly these two columns:

```
category,total_amount
```

(header is optional)

## Example Input (src/data.csv)

```csv
category,amount,quantity
A,100,5
B,200,3
A,150,2
B,300,4
A,50,1
```

## Expected Output (out/result.csv)

```csv
category,total_amount
A,300
B,500
```