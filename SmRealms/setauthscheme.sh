#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
AUTHSCHEME=$3
EXIST=$(bash SmAuthSchemes/exist.sh "$AUTHSCHEME")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    exit "$STATUS"
fi
EXIST=$(bash "${MYPATH}/exist.sh" "$NAME" "$CHILD"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    exit "$STATUS"
fi
JSON=$$.json
bash "${MYPATH}/temp/authscheme.temp" "$AUTHSCHEME" > "$JSON"
bash "${MYPATH}/update.sh" "$NAME" "$CHILD" "$JSON"
