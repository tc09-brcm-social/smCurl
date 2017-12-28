#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
SMREALM=$2
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @rule.json  "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmRealms/$SMREALM/SmRules"
