#!/bin/bash
MYPATH=`dirname $0`
SMACO=$1
ACO=`bash "${MYPATH}/read.sh" "$SMACO" | ./jq '.data'`
SORTATTR=`echo "$ACO" | ./jq '.Attributes | sort'`
ACONOATTR=`echo "$ACO" | ./jq 'del(.Attributes)'`
echo "$ACONOATTR" | ./jq -S ". + {Attributes: ${SORTATTR}}"
