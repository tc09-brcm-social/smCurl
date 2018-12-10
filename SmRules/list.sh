#!/bin/bash
MYPATH=`dirname $0`
SMDOMAIN=$1
SMREALM=$2
bash "${MYPATH}/read.sh" "$SMDOMAIN" "$SMREALM" | ./jq '.data | [.[]| .path]'
