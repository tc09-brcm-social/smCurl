#!/bin/bash
MXMLFILE=$1
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
MYBASE=$(basename "$DIRNAME")
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
curl ${OPT} --header "host: ${RESTHOST}" -v -k -X POST --header 'Accept: application/json' \
    --header "${AUTHN}" --data-binary @"$MXMLFILE" \
    "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/${MYBASE}/import"
