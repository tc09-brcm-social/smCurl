#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
SMPOLICY=$2
JSON=$3
curl -k -X PUT --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${SMDOMAIN}/SmPolicies/${SMPOLICY}"
