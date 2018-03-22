#!/bin/bash
SMID=$1
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$SMID" | ./jq '.data | { type: .type, Name: .Name, Alias: .Alias}'
