#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
VALUE=$3
EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME" "$CHILD"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    exit "$STATUS"
fi
JSON=$$.json
echo '{ "'$(basename "$0" | cut -d. -f1 | cut -c4-)"\": $VALUE }" \
    > "$JSON"
bash "${MYPATH}/../update.sh" "$NAME" "$CHILD" "$JSON"
