# Prime or Not? – Pure Bash Edition

Write a Bash script named `execute.sh` that:

* Takes exactly one integer as a command-line argument (e.g., `./execute.sh 17`)
* Determines whether the number is:
  * Prime → output: `Prime`
  * Composite → output: `Composite`
  * Neither (for numbers ≤ 1, including negative and zero) → output: `Neither`
* Prints only one of those three words and exits

## Examples

```bash
$ bash execute.sh 7
Prime

$ bash execute.sh 12
Composite

$ bash execute.sh 1
Neither

$ bash execute.sh -5
Neither

$ bash execute.sh 2
Prime
```