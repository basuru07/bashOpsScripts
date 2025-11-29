#!/bin/bash
mapfile -t a < src/echoes/pattern.csv
n=${#a[@]}
max=0
start_time=$(date +%s.%N)

for ((i=0;i<n;i++)); do
  for ((j=i;j<n;j++)); do
    pal=1
    for ((l=i,r=j;l<r;l++,r--)); do
      (( ${a[l]} != ${a[r]} )) && pal=0 && break
    done
    ((pal && j-i+1 > max)) && max=$((j-i+1))
  done
done

end_time=$(date +%s.%N)
duration=$(echo "$end_time - $start_time" | bc)
printf "PALINDROME_DURATION:%.3f\n" "$duration"