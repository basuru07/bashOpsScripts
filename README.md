# Bash Scripts Challenges - Complete Guide

A comprehensive collection of Bash scripting challenges, organized from beginner to advanced levels. Each challenge tests different aspects of Bash programming, from basic string manipulation to complex system orchestration.

---

## Common Bash Flags Reference

- `mkdir -p` : Creates parent directories as needed (no error if existing)
- `read -p`  : Displays a prompt before reading input
- `cp -p`    : Preserves permissions, ownership, and timestamps
- `bash -c`  : Executes the command passed as a string
- `wc -c`    : Counts bytes in a file
- `tar -c`   : Creates a new archive
- `cp -v`    : Verbose mode (shows what the command is doing)
- `rm -f`    : Forces deletion without confirmation
- `cp -r`    : Recursive copy (directories and subdirectories)
- `ls -a`    : Shows hidden files (including dotfiles)
- `ls -l`    : Long listing format (permissions, ownership, size, date)

---

## 📚 Challenge Progression

### Beginner Level

1. **String Reverser – Ultra-Short Bash Edition**
2. **Reverse a String – Bash Golf Edition**
3. **Prime or Not?**
4. **CSV Aggregator – One-Liner Edition**

---

### Intermediate Level

5. **Days Between Two Dates**
6. **Days Between Two Dates – Pure Bash (Using `date` Command)**
7. **CSV Group & Sum – Amount Only**
8. **The Phantom C Compiler – Find and Compile Hidden C Code**
9. **Bitcoin Price Fetcher – Pure Bash API Call**

---

### Advanced Level

10. **XML to JSON Converter**
11. **NGINX Load Balancer Config Generator**
12. **Prometheus & Grafana Bootstrap Generator**
13. **Echoes of the Heptagon – Find Longest Palindromic Wave**
14. **ArgoCD Application Manifest Processor**
15. **ArgoCD Fragmented Application Processor**

---

## 🛠️ Prerequisites

- **Bash 4.0+**  
  Check with:
  ```bash
  bash --version


# Bash Scripting Complete Guide

## PHASE 1: VARIABLES & INPUT

### Variables

```bash
name="Basuru"
age=17
echo "My name is $name"
```

⚠️ **No spaces around `=`**

### User Input

```bash
read -p "Enter your name: " name
echo "Hello $name"
```

### Command Substitution

```bash
today=$(date)
echo "Today is $today"
```

---

## PHASE 2: CONDITIONS (VERY IMPORTANT)

### If / Else

```bash
if [ $age -ge 18 ]; then
  echo "Adult"
else
  echo "Minor"
fi
```

### File & Directory Checks

```bash
if [ -f file.txt ]; then
  echo "File exists"
fi

if [ -d folder ]; then
  echo "Directory exists"
fi
```

### String Comparisons

```bash
if [ "$name" == "Basuru" ]; then
  echo "Welcome"
fi
```

---

## PHASE 3: LOOPS (AUTOMATION POWER)

### for Loop

```bash
for i in 1 2 3 4 5; do
  echo $i
done
```

### while Loop

```bash
count=1
while [ $count -le 5 ]; do
  echo $count
  ((count++))
done
```

### Loop Through Files

```bash
for file in *.txt; do
  echo $file
done
```

---

## PHASE 4: FUNCTIONS

### Functions

```bash
greet() {
  echo "Hello $1"
}

greet Basuru
```

### Return Status

```bash
check_file() {
  [ -f "$1" ]
}

check_file test.txt && echo "Exists"
```

---

## PHASE 5: ARGUMENTS & FLAGS

### Script Arguments

```bash
echo "Script name: $0"
echo "First arg: $1"
echo "All args: $@"
```

Run:
```bash
./script.sh file.txt
```

### Argument Validation

```bash
if [ $# -lt 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi
```

---

## PHASE 6: ERROR HANDLING & DEBUGGING

### Exit Codes

```bash
command
echo $?
```

### Exit on Error

```bash
set -e
```

### Debug Mode

```bash
bash -x script.sh
```

---

## PHASE 7: TEXT PROCESSING (SUPER IMPORTANT)

### grep

```bash
grep "error" logfile.txt
```

### awk

```bash
awk '{print $1}' file.txt
```

### sed

```bash
sed 's/old/new/g' file.txt
```

---

## PHASE 8: FILE DESCRIPTORS & REDIRECTION

### Output Redirection

```bash
command > out.txt
command >> out.txt
command 2> error.txt
command &> all.txt
```

### Pipes

```bash
ps aux | grep root
```

---

## PHASE 9: CRON & AUTOMATION

### Cron Jobs

```bash
crontab -e
```

Example:
```bash
0 2 * * * /path/backup.sh
```

---

## PHASE 10: DEVOPS-LEVEL BASH (VERY IMPORTANT FOR YOU)

Since you're doing AWS & DevOps, learn these:

### AWS CLI in Bash

```bash
aws s3 ls
aws ec2 describe-instances
```

### Backup Script

```bash
#!/bin/bash
tar -czf backup.tar.gz /data
aws s3 cp backup.tar.gz s3://my-bucket/
```

### Server Health Check

```bash
df -h
free -m
uptime
```

---

## PHASE 11: BEST PRACTICES (PRO LEVEL)

Always use:

```bash
#!/usr/bin/env bash
set -euo pipefail
```

Use quotes:

```bash
"$var"
```

Follow naming conventions:

```bash
readonly SCRIPT_DIR
```
  
