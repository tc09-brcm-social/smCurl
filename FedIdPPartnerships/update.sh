#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
Name=$1
JSON=$2
curl -s -k -X PUT --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/FedIdPPartnerships/$Name"
