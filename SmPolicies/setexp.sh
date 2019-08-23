#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
EXP=$3
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME" "$CHILD"); then
   STATUS=$?
   echo "$EXIST"
   exit "$STATUS"
fi
JSON=$$.json
./jq -n '.' | bash "${MYPATH}/jsetexp.sh" "$EXP"  > "$JSON"
bash "${MYPATH}/update.sh" "$NAME" "$CHILD" "$JSON"
