# The Phantom C Compiler

There is a hidden C source file named `phantom.c` somewhere in the project (could be in `src/`, root, or any subdirectory).

## Your Task

Write a single Bash script called `execute.sh` that:

* Finds the file `phantom.c` no matter where it is
* Compiles it into an executable named `phantom` (or `phantom.exe` on Windows)
* Places the executable in the `out/` directory
* The compiled program must print exactly these two lines when run:

```
Greetings from the phantom realm!
The compilation was successful.
```

* Must recompile every time the script is run (even if source didn't change)
* Must work on both Linux and Windows runners
* Must use a proper C compiler (`gcc`, `clang`, or `cc`)

## Requirements

* The script must perform a recursive search to locate `phantom.c`
* Compilation must produce a working executable in the `out/` directory
* Output format must match exactly (no extra spaces, newlines, or text)
* No caching or skipping compilation — always recompile on each run