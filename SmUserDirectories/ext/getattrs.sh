#!/bin/bash
NAME=$1
MYPATH=$(dirname "$0")
JSON=$$.json
EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME") ; STATUS=$?
if [[ "$STATUS" != 0 ]]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo "$EXIST" | ./jq '.data | {
    "Universal ID": .UniversalIDAttribute,
    "Disabled Flag": .DisabledAttribute,
    "Password": .PasswordAttribute,
    "Password Data": .BlobAttribute,
    "Anonymous ID": .GuidAttribute,
    "Email": .EmailAddrAttribute,
    "Challenge/Response": .ChallengeRespAttribute }'
