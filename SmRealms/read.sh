#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
NAME=$1
CHILD=$2
if [[ -z "${NAME}" ]]; then
    curl -s -k -X GET --header 'Accept: application/json' \
        --header "${AUTHN}" \
        "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmRealms/"
else
    curl -s -k -X GET --header 'Accept: application/json' \
        --header "${AUTHN}" \
        "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${NAME}/SmRealms/${CHILD}"
fi
