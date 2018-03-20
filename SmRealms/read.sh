#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
Name=$2
curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${SMDOMAIN}/SmRealms/${Name}"
