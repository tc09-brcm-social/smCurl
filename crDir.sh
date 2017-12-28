#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
JSON=$$.json
SMDIR=$1
SMDIRHOST=$2
SMDIRPORT=$3
bash dir.temp "$SMDIR" "$SMDIRHOST" "$SMDIRPORT" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON \
"https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmUserDirectories"
