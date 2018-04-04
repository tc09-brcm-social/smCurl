#!/bin/bash
Domain=$1
Name=$2
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
if [[ -z "${Domain}" ]]; then
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmResponses/"
    else
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${Domain}/SmResponses/${Name}"
fi
