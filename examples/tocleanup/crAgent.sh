#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/authn"
SMAGENT=$1
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash agent.temp "$SMAGENT" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmAgents"
