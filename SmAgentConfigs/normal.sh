#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
ACO=$(echo "$EXIST" | ./jq '.data')
SORTATTR=$(echo "$EXIST" | ./jq '.data.Attributes | sort')
echo "$EXIST" | ./jq -S --argjson a "$SORTATTR" '.data | . + {Attributes: $a}'
