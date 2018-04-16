#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
SMREALM=$2
SMRULE=$3
JSON=$4
curl -s -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmPolicies/"
