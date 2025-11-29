#!/bin/bash
for((i=${#1};i;));{ printf ${1--i}:; }