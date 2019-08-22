#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
JSON=$$.json
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
./jq -n '. + { Status: "Active" }' > "$JSON"
bash "${MYPATH}/update.sh" "$NAME" "$JSON"
