# Days Between Two Dates

Write a single Bash script called `execute.sh` that:

* Takes exactly two arguments — two dates in `YYYY-MM-DD` format (Example: `bash execute.sh 2024-01-01 2024-12-31`)
* Calculates the absolute number of days between them (full day difference, same as JavaScript `Math.abs(d2 - d1) / 86400000`)
* Outputs only a single integer (no extra text, no negative signs)
* Must correctly handle:
  * Leap years (2020, 2024)
  * Same date → `0`
  * Dates in any order (reverse → same positive result)
  * Feb 28 → March 1 in leap/non-leap years

## Examples

```bash
$ bash execute.sh 2024-01-01 2024-12-31
365

$ bash execute.sh 2020-01-01 2020-12-31
366   # leap year

$ bash execute.sh 2024-02-28 2024-03-01
2

$ bash execute.sh 2023-02-28 2023-03-01
1

$ bash execute.sh 2024-06-15 2024-06-15
0

$ bash execute.sh 2024-12-31 2024-01-01
365   # reverse order
```