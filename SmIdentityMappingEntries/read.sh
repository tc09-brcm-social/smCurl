#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
SMMAPPING=$1
Name=$2
if [[ -z "${SMMAPPING}" ]]; then
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmIdentityMappingEntries/"
    else
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmIdentityMappings/${SMMAPPING}/SmIdentityMappingEntries/${Name}"
fi
