#!/bin/bash
MYPATH=`dirname $0`
SMDOMAIN=$1
bash "${MYPATH}/read.sh" "$SMDOMAIN" | ./jq '.data | [.[]| { "path": .path} ]'
