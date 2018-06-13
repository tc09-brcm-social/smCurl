#!/bin/bash
Name=$1
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
curl -s -k -X GET --header 'Accept: application/json' --header "${AUTHN}" "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/FedSPRemotes/${Name}"
