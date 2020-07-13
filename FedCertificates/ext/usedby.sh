#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$EXIST"
    exit "$STATUS"
fi
OBJ=$(basename $(echo "$EXIST" | ./jq -r '.links.self.href'))/usedby
bash objects/read.sh "$OBJ" | ./jq '.data'
