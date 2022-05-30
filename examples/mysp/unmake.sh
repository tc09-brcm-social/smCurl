#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
cd "$MYPATH"
. ./env.shlib "$MYPATH"
#
## LSP
#
SMSP=$SPNAME
EXIST=$(bash FedSPLocals/exist.sh "$SMSP"); STATUS=$?
if [[ "$STATUS" -eq 0 ]]; then
    >&2 echo "Removing Local SP $SMSP"
    bash FedSPLocals/delete.sh "$SMSP"
else
    >&2 echo "Local SP $SMSP does not exist, skipped"
fi
#
## Cert
#
rmCert() {
    local _cert=$1
    EXIST=$(bash FedCertificates/exist.sh "$_cert"); STATUS=$?
    if [[ "$STATUS" -eq 0 ]]; then
        >&2 echo "Removing certificate $_cert"
        bash FedCertificates/delete.sh "$_cert"
    else
        >&2 echo "Certificate $_cert does not exist, skipped"
    fi
    }

rmCert "$SIGNCERT"
rmCert "$ENCCERT"
