#!/bin/bash
MYBASE=$(dirname $0)
. "${MYBASE}/env.shlib"
SMCERT=$1
FQDN=$2
EXIST=$(bash FedCertificates/exist.sh "$SMCERT")
STATUS=$?
if [[ "$STATUS" -eq 0 ]]; then
    >&2 echo Certificate name "$SMCERT exists, skip creating"
    STATUS=1
else
    CRT=$SMCERT.crt
    KEY=$SMCERT.key
    P12=$SMCERT.p12
    openssl req \
      -x509 -nodes -days 3650 \
      -subj "/CN=${FQDN}" \
      -newkey rsa:2048 -keyout "${KEY}" -out "${CRT}"
    openssl pkcs12 -export -out "${P12}" -inkey "${KEY}" -in "${CRT}" \
        -password pass:${MYCERTPASS}
    EXIST=$(bash FedCertificates/impp12.sh "$SMCERT" "${P12}" "${MYCERTPASS}")
    STATUS=$?
fi
echo "$EXIST"
exit "$STATUS"
