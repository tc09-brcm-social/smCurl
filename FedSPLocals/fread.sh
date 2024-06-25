#!/bin/bash
FILTER=$1
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYBASE=$(basename "$DIRNAME")
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
curl ${OPT} --header "host: ${RESTHOST}" -s -k -X GET --header 'Accept: application/json' \
    --header "${AUTHN}" \
    "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/${MYBASE}/?filter=$(urlencode "$FILTER")"
