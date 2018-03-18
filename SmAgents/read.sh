#!/bin/bash
Name=$1
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmAgents/${Name}"
