#!/bin/bash
MYPATH=`dirname $0`
SMOLD=$1
SMNEW=$2
JSON=$$.json
EXIST=`bash "${MYPATH}/exist.sh" "$SMNEW"`
if [[ $? == 0 ]]; then
    >&2 echo "$SMNEW already exists."
    exit 1
fi
EXIST=`bash "${MYPATH}/exist.sh" "$SMOLD"`
if [[ $? != 0 ]]; then
    exit 1
fi
echo "$EXIST" | ./jq --arg new "$SMNEW" \
	'.data | .Name = $new' >"$JSON"
bash "${MYPATH}/update.sh" "$SMOLD" "$JSON"
