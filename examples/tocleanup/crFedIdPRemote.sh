#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/authn"
SMRIDPNAME=$1
SMRIDPTEMP=$2
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMRIDPTEMP" "$SMRIDPNAME" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/FedIdPRemotes/"
