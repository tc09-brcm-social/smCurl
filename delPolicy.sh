#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/authn"
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
SMPOLICY=$2
curl -k -X DELETE --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmPolicies/$SMPOLICY"
