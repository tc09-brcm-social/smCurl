#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
if ! LIST=$(bash "${MYPATH}/list.sh" "$NAME" "$CHILD"); then
    STATUS=$?
    ./jq -n '. + []'
    exit "$STATUS"
fi
echo "$LIST" | ./jq '[.[]| { path: .} ]'
