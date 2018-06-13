#!/bin/bash
SMAUTH=$1
SMAUTHTEMP=$2
JSON=$$.json
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/authn"
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMAUTHTEMP" "$SMAUTH" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmAuthSchemes"
