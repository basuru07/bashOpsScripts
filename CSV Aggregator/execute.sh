#!/bin/bash
mkdir -p out
tail -n+2 src/data.csv|awk -F, '{s[$1]+=$2}END{print"category,total_amount";for(i in s)print i","s[i]}'|sort >out/result.csv