#!/bin/bash
. ./authn
SMLSPNAME=$1
SMLSPTEMP=$2
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMLSPTEMP" "$SMLSPNAME" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/FedSPLocals/"
