#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
GRANDCHILD=$3
if ! JSONDATA=$(bash "${MYPATH}/jsave.sh" "$NAME" "$CHILD" "$GRANDCHILD"); then
    STATUS=$?
    echo "$JSONDATA"
    exit 1
fi
JSON=$$.json
echo "$JSONDATA" > "$JSON"
bash "${MYPATH}/create.sh" "$NAME" "$CHILD" "$JSON"
