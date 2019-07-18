#!/bin/bash
Name=$1
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$Name" | ./jq '.data | [.[]| .path]'
