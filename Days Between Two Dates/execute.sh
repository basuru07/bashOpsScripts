#!/bin/bash
a=$(date -d "$1" +%s)
b=$(date -d "$2" +%s)
echo $(( ($a - $b) / 86400 )) | tr -d '-'