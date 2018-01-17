#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
JSON=$$.json
SMDIR=$1
SMDIRHOST=$2
SMDIRPORT=$3
SMDIRROOT=$4
SMDIRID=$5
SMDIRPWD=$6
SMDIRUID=$7
SMDIRTEMP=$8
bash "$SMDIRTEMP" "$SMDIR" "$SMDIRHOST" "$SMDIRPORT" "$SMDIRROOT" "$SMDIRID" "$SMDIRPWD" "$SMDIRUID" > $JSON
curl -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON \
"https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmUserDirectories"
