#!/bin/bash
Name=$1
Fmt=$2
Pwd=$3
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
AUTHN="Authorization: Bearer ${TOKEN}"
JSON=$$.json
./jq --arg a "$Name" --arg f "$Fmt" --arg p "$Pwd" \
        -n '. + { Alias: $a, Password: $p, Format: $f }' > "$JSON"
curl -s -k -X POST --header "${AUTHN}" -d @$JSON  "https://$RESTHOST:${RESTPORT}/ca/api/sso/services/policy/v1/FedCertificates"

