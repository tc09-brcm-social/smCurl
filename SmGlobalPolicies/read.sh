#!/bin/bash
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
SMDOMAIN=$1
Name=$2
if [[ -z "${SMDOMAIN}" ]]; then
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmGlobalPolicies/"
    else
    curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmDomains/${SMDOMAIN}/SmGlobalPolicies/${Name}"
fi
