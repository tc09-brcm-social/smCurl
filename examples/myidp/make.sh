#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
cd "$MYPATH"
. ./env.shlib "$MYPATH"
#
## Cert
#
SMCERT=$CERT
if ! EXIST=$(bash FedCertificates/exist.sh "$SMCERT") ; then
    >&2 echo "Certificate $SMCERT does not yet exit. Creating a self-signed one ..."
    EXIST=$(bash FedCertificates/ext/selfsigned.sh "$SMCERT" "$FQDN")
fi
echo "$EXIST" | ./jq '.data'
#
## LIDP
#
SMIDP=$IDPNAME
if EXIST=$(bash FedIdPLocals/exist.sh "$SMIDP"); then
    >&2 echo "Local IdP $SMIDP exits. skip creation"
else
    JSON=$$.json
    bash "$IDPTEMP" "$SMIDP" "$FQDN" "$SHORTID" "$FEDBASE" "$SMCERT" > "$JSON"
    EXIST=$(bash FedIdPLocals/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
