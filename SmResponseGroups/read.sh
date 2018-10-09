#!/bin/bash
Domain=$1
Name=$2
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
if [[ -z "${Domain}" ]]; then
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmResponseGroups/"
    else
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${Domain}/SmResponseGroups/${Name}"
fi
