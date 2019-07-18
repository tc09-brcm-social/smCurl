#!/bin/bash
MYPATH=`dirname $0`
SMACO=$1
EXIST=`bash "${MYPATH}/exist.sh" "$SMACO"`
if [[ $? != 0 ]]; then
    exit 1
fi
ACO=`echo "$EXIST" | ./jq '.data'`
SORTATTR=`echo "$ACO" | ./jq '.Attributes | sort'`
ACONOATTR=`echo "$ACO" | ./jq 'del(.Attributes)'`
#echo "$ACONOATTR" | ./jq -S ". + {Attributes: ${SORTATTR}}"
echo "$ACONOATTR" | ./jq -S --argjson a "$SORTATTR" '. + {Attributes: $a}'
