#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
PASSWD=$2
if [ -z "$PASSWD" ]; then
    >&2 echo "Password is mandatory when attempt to export PKCS12"
    exit 1
fi
EXIST=$(bash "${MYPATH}/exist.sh" "$NAME")
RESP=$(echo "$EXIST" | ./jq -r '.responseType')
if [ "$RESP" == "error" ]; then
    >&2 echo "$NAME does not exist."
    exit 1
fi
TYPE=$(echo "$EXIST" | ./jq -r '.data.CertificateType')
if [ "$TYPE" != "KeyEntry" ]; then
    >&2 echo "$NAME is of type '$TYPE', p12 export is not possible."
    exit 1
fi
JSON=$$.json
bash "${MYPATH}/temp/expp12.temp" "$NAME" "$PASSWD" > "$JSON"
bash "${MYPATH}/export.sh" "$JSON" | ./jq -r '.data.CertificateData' | base64 -d
