# CSV Group & Sum – Amount Only

You are given a CSV file located at: `src/data.csv`

With this exact header:

```csv
category,amount,quantity
```

## Your Task

Write a single Bash script named `execute.sh` that:

* Reads `src/data.csv`
* Groups all rows by the `category` column
* Calculates the total sum of the `amount` column for each category
* Outputs a new CSV file at `out/result.csv` containing:

```
category,total_amount
```

(Header is optional — not required by tests)

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
A,300
B,500
```

or with header:

```csv
category,total_amount
A,300
B,500
```

Both are accepted.