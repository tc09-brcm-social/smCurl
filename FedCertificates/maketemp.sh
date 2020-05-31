#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
PASSWD=$2
EXIST=$(bash ${MYPATH}/exist.sh "$NAME")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$EXIST"
    exit "$STATUS"
fi
TYPE=$(echo "$EXIST" | ./jq -r '.data.CertificateType')
if [ "$TYPE" == "TrustedCA" ]; then
    bash "${MYPATH}/maketempca.sh" "$NAME"
fi
if [ "$TYPE" == "Certificate" ]; then
    bash "${MYPATH}/maketemppem.sh" "$NAME"
fi
if [ "$TYPE" == "KeyEntry" ]; then
    bash "${MYPATH}/maketempp12.sh" "$NAME" "$PASSWD"
fi
