#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
NAME=$1
CHILD=$2
curl ${OPT} --header "host: ${RESTHOST}" -s -k -X DELETE --header 'Accept: application/json' \
    --header "${AUTHN}" \
    "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${NAME}/SmRealms/${CHILD}"
