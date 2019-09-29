#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
GRANDCHILD=$3
APP='.'$(date +"%Y%m%d%N")
JSON=$$.json
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME" "$CHILD" "$GRANDCHILD"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | \
	./jq --arg app "$APP" \
	'.Name = (.Name + $app)' | \
	bash "${MYPATH}/jsetdisabled.sh"
