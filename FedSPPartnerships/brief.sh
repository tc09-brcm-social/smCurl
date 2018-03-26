#!/bin/bash
MYPATH=`dirname $0`
Name=$1
bash "${MYPATH}/read.sh" "$Name" | ./jq '.data | {Name: .Name, Status: .Status}'
