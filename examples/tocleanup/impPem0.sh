#!/bin/bash
JSON=$1
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/authn"
AUTHN="Authorization: Bearer ${TOKEN}"
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/CdsCertificates"
