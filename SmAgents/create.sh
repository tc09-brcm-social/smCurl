#!/bin/bash
JSON=$1
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
curl -s -k -X POST --header 'Accept: application/json' --header "${AUTHN}" -d @$JSON  "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmAgents"
