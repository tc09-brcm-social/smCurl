#!/bin/bash
NAME=$1
MYPATH=$(dirname "$0")
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME"); then
    STATUS=$?
    ./jq -n '. + []'
    exit "$STATUS"
fi
RESP=$(echo "$EXIST" | ./jq -r '.responseType')
if [ "$RESP" == "object" ]; then
    echo "$EXIST" | ./jq '[ .parent.path + "/" + .data.type + "s/" + .data.Name]'
fi
if [ "$RESP" == "links" ]; then
    DATA=$(echo "$EXIST" | ./jq '.data')
    if [ "$DATA" == "null" ]; then
        >&2 echo "$NAME does not exist."
        ./jq -n '. + []'
        exit 1
    fi
    echo "$DATA" | ./jq '[.[]| .path]'
fi
