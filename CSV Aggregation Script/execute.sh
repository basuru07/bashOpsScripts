#!/bin/bash
mkdir -p out; tail -n+2 src/data.csv|awk -F, '{a[$1]+=$2}END{print "category,total_amount";for(i in a)print i","a[i]}'|sort > out/result.csv