# CSV Aggregator – One-Liner Edition (Bashaway)

You are given a CSV file at `src/data.csv`

The file will always have these three columns (in this order): `category`, `amount`, `quantity`

Your task is to write exactly one Bash script named `execute.sh` that:

* Reads `src/data.csv`
* Groups the rows by the `category` column
* For each category, calculates the sum of the `amount` column
* Writes a new CSV file to `out/result.csv` with exactly these two columns:

```
category,total_amount
```

(the header line is optional but accepted)

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

or simply:

```csv
A,300
B,500
```