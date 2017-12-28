#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
JSON=$$.json
SMDIR=$2
APPVDIR=$1
bash domain.temp "$APPVDIR" "$SMDIR"> $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains"
