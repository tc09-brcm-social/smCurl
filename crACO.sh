#!/bin/bash
SMACO=$1
SMACOTEMP=$2
SMAGENT=$3
JSON=$$.json
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMACOTEMP" "$SMACO" "$SMAGENT" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmAgentConfigs"
