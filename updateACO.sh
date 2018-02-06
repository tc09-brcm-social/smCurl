#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMACO=$1
JSON=$2
curl -k -X PUT --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmAgentConfigs/$SMACO"
