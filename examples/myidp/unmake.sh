#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
cd "$MYPATH"
. ./env.shlib "$MYPATH"
#
## LIDP
#
SMIDP=$IDPNAME
if EXIST=$(bash FedIdPLocals/exist.sh "$SMIDP"); then
    >&2 echo "Removing Local IdP $SMIDP"
    bash FedIdPLocals/delete.sh "$SMIDP"
else
    >&2 echo "Local IdP $SMIDP does not exist, skipped"
fi
#
## Cert
#
SMCERT=$CERT
if EXIST=$(bash FedCertificates/exist.sh "$SMCERT"); then
    >&2 echo "Removing certificate $SMCERT"
    bash FedCertificates/delete.sh "$SMCERT"
else
    >&2 echo "Certificate $SMCERT does not exist, skipped"
fi
