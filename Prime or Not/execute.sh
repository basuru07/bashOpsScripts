#!/bin/bash
n=$1
[[ $n -le 1 ]] && echo Neither && exit
[[ $n -eq 2 ]] && echo Prime && exit
[[ $((n%2)) -eq 0 ]] && echo Composite && exit
for ((i=3;i*i<=n;i+=2));do
  ((n%i==0))&&echo Composite&&exit
done
echo Prime