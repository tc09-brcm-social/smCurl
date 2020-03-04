#!/bin/bash
SMDOMAIN=$1
JSON=$2
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
curl ${OPT} --header "host: ${RESTHOST}" -s -k -X POST --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --header "${AUTHN}" -d @"$JSON" \
    "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmVariables/"
