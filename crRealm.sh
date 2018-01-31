#!/bin/bash
. ./authn
SMREALM=$1
SMREALMTEMP=$2
APPVDIR=$3
SMAGENT=$4
SMAUTH=$5
SMDOMAIN=$6
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMREALMTEMP" "$SMREALM" "$APPVDIR" "$SMAGENT" "$SMAUTH" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmRealms/"
