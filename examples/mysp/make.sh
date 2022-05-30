#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
cd "$MYPATH"
. ./env.shlib "$MYPATH"
#
## Certs
#
SMCERT=$SIGNCERT
EXIST=$(bash FedCertificates/exist.sh "$SMCERT"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    EXIST=$(bash FedCertificates/ext/selfsigned.sh "$SMCERT" "$FQDN")
fi
echo "$EXIST" | ./jq '.data'
SMCERT=$ENCCERT
EXIST=$(bash FedCertificates/exist.sh "$SMCERT"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    EXIST=$(bash FedCertificates/ext/selfsigned.sh "$SMCERT" "$FQDN")
fi
echo "$EXIST" | ./jq '.data'
#
## LSP
#
SMSP=$SPNAME
EXIST=$(bash FedSPLocals/exist.sh "$SMSP"); STATUS=$?
if [[ "$STATUS" -eq 0 ]]; then
    >&2 echo "Local SP $SMSP exits. skip creation"
else
    JSON=$$.json
    bash "$SPTEMP" "$SMSP" "$FQDN" "$SHORTID" "$FEDBASE" "$SIGNCERT" "$ENCCERT" > "$JSON"
    EXIST=$(bash FedSPLocals/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
