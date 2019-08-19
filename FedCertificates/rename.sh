#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
NEWNAME=$2
JSON=$$.json
if EXIST=$(bash "${MYPATH}/exist.sh" "$NEWNAME"); then
    >&2 echo "$NEWNAME already exists."
    exit 1
fi
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
#echo "$EXIST" | ./jq --arg new "$NEWNAME" \
#	'.data | .Name = $new' >"$JSON"
./jq -n --arg n "$NEWNAME" '. + {Alias: $n}' > "$JSON"
bash "${MYPATH}/update.sh" "$NAME" "$JSON"
