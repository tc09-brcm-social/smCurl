#!/bin/bash
. ./authn
SMREALM=$1
APPVDIR=$2
SMAGENT=$3
SMAUTH=$4
SMDOMAIN=$5
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash realm0.temp "$SMREALM" "$APPVDIR" "$SMAGENT" "$SMAUTH" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmRealms/"
