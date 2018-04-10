#!/bin/bash
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" | ./jq '.data | [.[]| .path]'
