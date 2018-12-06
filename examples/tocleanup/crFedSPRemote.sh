#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/authn"
SMRSPNAME=$1
SMRSPTEMP=$2
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMRSPTEMP" "$SMRSPNAME" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/FedSPRemotes/"
