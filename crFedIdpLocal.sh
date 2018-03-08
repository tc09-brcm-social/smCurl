#!/bin/bash
. ./authn
SMLIDPNAME=$1
SMLIDPTEMP=$2
JSON=$$.json
AUTHN="Authorization: Bearer ${TOKEN}"
bash "$SMLIDPTEMP" "$SMLIDPNAME" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/FedIdPLocals/"
