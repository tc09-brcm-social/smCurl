#!/bin/bash
MYPATH=`dirname $0`
SMACO=$1
APP='.'`date +"%Y%m%d%N"`
JSON=$$.json
bash "${MYPATH}/read.sh" "$SMACO" | ./jq --arg app "$APP" \
	'.data | del(.id) | .Name = (.Name + $app)' >"$JSON"
bash "${MYPATH}/create.sh" "$JSON"
