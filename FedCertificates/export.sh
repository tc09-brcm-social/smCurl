#!/bin/bash
JSON=$1
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
curl ${OPT} --header "host: ${RESTHOST}" -s -k -X POST --header "${AUTHN}" \
    -d @"$JSON" \
    "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/FedCertificates"
