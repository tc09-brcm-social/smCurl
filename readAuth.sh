#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMAUTH=$1
curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmAuthSchemes/$SMAUTH"
