#!/bin/bash
. ./authn
APPVDIR=$1
SMAGENT=$2
SMAUTH=$3
SMDOMAIN=$4
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash realm.temp "$APPVDIR" "$SMAGENT" "$SMAUTH" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmRealms/"
