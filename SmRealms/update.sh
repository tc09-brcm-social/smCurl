#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYBASE=$(basename "$DIRNAME")
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
NAME=$1
CHILD=$2
JSON=$3
curl ${OPT} --header "host: ${RESTHOST}" -s -k -X PUT --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --header "${AUTHN}" -d @"$JSON" \
    "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${NAME}/${MYBASE}/${CHILD}"
