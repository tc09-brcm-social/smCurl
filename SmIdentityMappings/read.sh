#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
Name=$1
curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmIdentityMappings/$Name"
