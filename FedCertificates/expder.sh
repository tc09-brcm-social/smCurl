#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
EXIST=$(bash "${MYPATH}/exist.sh" "$NAME")
RESP=$(echo "$EXIST" | ./jq -r '.responseType')
if [ "$RESP" == "error" ]; then
    >&2 echo "$NAME does not exist."
    exit 1
fi
JSON=$$.json
bash "${MYPATH}/temp/expder.temp" "$NAME" "$PASSWD" > "$JSON"
bash "${MYPATH}/export.sh" "$JSON" | ./jq -r '.data.CertificateData' | base64 -d
