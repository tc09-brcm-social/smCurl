#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
READ=$(bash "${MYPATH}/read.sh" "$NAME" "$CHILD")
echo "$READ"
RESP=$(echo "$READ" | ./jq -r '.responseType')
if [ "$RESP" == "error" ]; then
    >&2 echo "$CHILD of $NAME does not exist."
    exit 1
fi
