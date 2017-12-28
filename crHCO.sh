#!/bin/bash
SMHCO=$1
SMPSHOST=$2
JSON=$$.json
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
bash hco.temp "$SMHCO" "$SMPSHOST" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmHostConfigs"
