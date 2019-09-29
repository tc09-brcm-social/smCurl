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
TONULL=$(echo "$TO" | ./jq '.data' | bash utils/jdelattrs.sh)
if ! FROM=$(bash "${MYPATH}/exist.sh" "$FROMNAME"); then
    STATUS=$?
    echo "$FROM"
    exit "$STATUS"
fi
CLEAN=$(echo "$FROM" | ./jq '.data' | bash "$MYPATH/cleanse.sh")
for i in $(echo "$CLEAN" | ./jq -r 'keys[]'); do
    VALUE=$(echo "$CLEAN" | ./jq ".$i")
    TONULL=$(echo "$TONULL" | ./jq  ". + { $i: $VALUE}")
done
echo "$TONULL" | \
    ./jq 'del(.id, .Name)' > "$JSON"
bash "${MYPATH}/update.sh" "$TONAME" "$JSON"
