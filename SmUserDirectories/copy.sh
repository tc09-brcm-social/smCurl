#!/bin/bash
MYPATH=$(dirname "$0")
TONAME=$1
FROMNAME=$2
JSON=$$.json
if ! TO=$(bash "${MYPATH}/exist.sh" "$TONAME"); then
    STATUS=$?
    echo "$TO"
    exit "$STATUS"
fi
if ! FROM=$(bash "${MYPATH}/exist.sh" "$FROMNAME"); then
    STATUS=$?
    echo "$FROM"
    exit "$STATUS"
fi
TOID=$(echo "$TO" | ./jq -r '.data.id')
echo "$FROM" | ./jq '.data' | bash "$MYPATH/cleanse.sh" | \
	./jq --arg toid "$TOID" --arg toname "$TONAME" \
	'.id = $toid | .Name = $toname' >"$JSON"
bash "${MYPATH}/update.sh" "$TONAME" "$JSON"
