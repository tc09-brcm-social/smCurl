#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
EXIST=$(bash "${MYPATH}/exist.sh" "$NAME")
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "$EXIST"
    exit "$STATUS"
fi
ACO=$(echo "$EXIST" | ./jq '.data')
SORTATTR=$(echo "$EXIST" | ./jq '.data.Attributes | sort')
echo "$EXIST" | ./jq -S --argjson a "$SORTATTR" '.data | . + {Attributes: $a}'
