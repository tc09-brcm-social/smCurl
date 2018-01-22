#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMID=$1
curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/objects/$SMID"
