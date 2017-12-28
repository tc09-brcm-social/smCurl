#!/bin/bash
. ./authn
SMDOMAIN=$1
SMREALM=$2
AUTHN="Authorization: Bearer ${TOKEN}"
curl -k -X DELETE --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/$SMDOMAIN/SmRealms/$SMREALM"
