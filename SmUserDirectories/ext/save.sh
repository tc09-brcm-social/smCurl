#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
APP='.'$(date +"%Y%m%d%N")
JSON=$$.json
if ! EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/../cleanse.sh" | \
	./jq --arg app "$APP" \
	'.Name = (.Name + $app)' >"$JSON"
bash "${MYPATH}/../create.sh" "$JSON"
