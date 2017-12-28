#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
JSON=$$.json
SMADMIN=$1
SMADMINPWD=$2
bash smlegadmins.temp "$SMADMIN" "$SMADMINPWD"> $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmAdmins"
