#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYBASE=$(basename "$DIRNAME")
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
NAME=$1
CHILD=$2
GRANDCHILD=$3
if [[ -z "${NAME}" ]]; then
    curl -s -k -X GET --header 'Accept: application/json' \
        --header "${AUTHN}" \
        "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/${MYBASE}/"
    else
    if [[ -z "${CHILD}" ]]; then
        curl -s -k -X GET --header 'Accept: application/json' \
        --header "${AUTHN}" \
        "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$NAME/${MYBASE}/"
    else
        curl -s -k -X GET --header 'Accept: application/json' \
        --header "${AUTHN}" \
        "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$NAME/SmRealms/$CHILD/${MYBASE}/$GRANDCHILD"
    fi
fi
