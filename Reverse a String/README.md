# Reverse a String

Write a single Bash script named `execute.sh` that:

* Takes one argument – any string (can contain spaces, special characters, numbers, etc.)
* Prints the exact reverse of that string
* Outputs only the reversed string (no extra spaces or newlines)
* Must handle:
  * Empty strings → output nothing
  * Single characters → same character
  * Spaces and special characters correctly
  * Strings with quotes, punctuation, etc.

## Examples

```bash
$ bash execute.sh "hello world"
dlrow olleh

$ bash execute.sh "Test@123!"
!321@tseT

$ bash execute.sh "a"
a

$ bash execute.sh ""
<empty>
```