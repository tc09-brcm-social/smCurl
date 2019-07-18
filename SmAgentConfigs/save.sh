#!/bin/bash
MYPATH=`dirname $0`
SMACO=$1
APP='.'`date +"%Y%m%d%N"`
JSON=$$.json
EXIST=`bash "${MYPATH}/exist.sh" "$SMACO"`
if [[ "$?" != 0 ]]; then
    exit 1
fi
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | \
	./jq --arg app "$APP" \
	'.Name = (.Name + $app)' >"$JSON"
bash "${MYPATH}/create.sh" "$JSON"
