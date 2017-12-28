#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
JSON=$$.json
SMDOMAIN=$1
SMREALM=$2
SMRULE=$3
SMDIR=$4
bash policy.temp "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmPolicies/"
