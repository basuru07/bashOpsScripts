# The Phantom C Compiler

You are given a hidden C source file named `phantom.c` located somewhere in the project (most likely in `src/` or root).

Your task is to write a Bash script called `execute.sh` that:

## Must Do

1. Compile the file `phantom.c` into a working executable
2. Place the final executable inside the folder `./out/`
3. Name the executable `phantom` (or `phantom.exe` on Windows)
4. The compiled program must:
   - Print exactly these two lines when run:

```
Greetings from the phantom realm!
The compilation was successful.
```