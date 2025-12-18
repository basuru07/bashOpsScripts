#!/bin/bash
# This script analyzes a log file and provides a summary

# count the number of ERROR 
echo "Error count: $(grep -c ERROR server.log)"
# count the number of WARNING
echo "Warning count: $(grep -c WARNING server.log)"
# count the number of INFO
echo "Info count: $(grep -c INFO server.log)"
# list unique IP addresses
echo "Unique IPs:"
# 
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' server.log | sort | uniq
