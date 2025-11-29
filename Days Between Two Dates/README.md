# Days Between Two Dates

Write a Bash script named `execute.sh` that:

* Takes exactly two arguments — two dates in the format `YYYY-MM-DD` (e.g., `bash execute.sh 2024-01-01 2024-12-31`)
* Calculates the absolute number of days between them (exclusive, standard day difference)
* Prints only the number of full days between the two dates
* Must handle:
  * Leap years correctly (like 2020, 2024)
  * Dates in any order (reverse order must give same result)
  * Same date → output `0`
  * Large gaps, small gaps, leap year boundaries

## Examples

```bash
$ bash execute.sh 2024-01-01 2024-01-01
0

$ bash execute.sh 2024-01-01 2024-01-02
1

$ bash execute.sh 2024-02-28 2024-03-01
2        # 2024 is leap year → Feb has 29 days

$ bash execute.sh 2023-02-28 2023-03-01
1        # 2023 not leap → Feb 28 → March 1 = 1 day

$ bash execute.sh 2020-01-01 2020-12-31
365      # 2020 was leap year
```