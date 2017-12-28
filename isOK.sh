#!/bin/bash
. ./authn
AUTHN="Authorization: Bearer ${TOKEN}"
curl -k -X GET --header 'Accept: application/json' --header "${AUTHN}" \
"https://${RESTHOST}:${RESTPORT}/ca/api/sso/services/policy/v1/SmAdmins"
echo This is to verify whether authn is set correctly.
echo If the result of the run is ok, ${RESTHOST} and ${TOKEN} work together
