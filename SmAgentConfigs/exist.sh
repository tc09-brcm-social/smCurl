#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
READ=$(bash "${MYPATH}/read.sh" "$NAME")
echo "$READ"
RESP=$(echo "$READ" | ./jq -r '.responseType')
if [ "$RESP" == "error" ]; then
    >&2 echo "$NAME does not exist."
    exit 1
fi
