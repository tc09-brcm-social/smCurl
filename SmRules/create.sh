#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
SMREALM=$2
JSON=$3
curl -s -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @${JSON}  "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmRealms/$SMREALM/SmRules"
