# Challenge: "String Reverser" – Ultra-Short Bash Edition

Write a Bash script called `execute.sh` that:

* Takes exactly one argument — a string (can contain spaces, special characters, numbers, etc.)
* Prints the exact reverse of that string
* Prints nothing else (no extra spaces or newlines except the final one)

## Examples

```bash
$ bash execute.sh "hello"
olleh

$ bash execute.sh "Hello World!"
!dlroW olleH

$ bash execute.sh "abc 123 @#"
#@ 321 cba

$ bash execute.sh ""
<empty line>

$ bash execute.sh "a"
a
```