#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
Name=$2
curl -s -k -X DELETE --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmResponses/$Name"
