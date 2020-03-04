#!/bin/bash
MYPATH=$(dirname "$0")
. "${MYPATH}/authn"
AUTHN="Authorization: Bearer ${TOKEN}"
RESP=$(curl ${OPT} --header "host: ${RESTHOST}" -v -k -X GET --header 'Accept: application/json' --header "${AUTHN}" \
"https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmAdmins")
>&2 echo This is to verify whether file \"authn\" is set correctly.
>&2 echo If it works, it is using an Access Token:
>&2 echo "${TOKEN}"
>&2 echo to connect to \"${RESTHOST} : ${RESTPORT}\"
>&2 echo A list of SmAdmins retrieved:
echo "$RESP" |./jq '.data | .[] | .path'
