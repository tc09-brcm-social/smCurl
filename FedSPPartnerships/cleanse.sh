#!/bin/bash
MYPATH=$(dirname "$0")
DATA=$(cat)
POLICY=$(echo "$DATA" | ./jq '.Policy')
USER=$(echo "${POLICY}" | ./jq '.SmUserPolicies')
j=$(echo "$USER" | ./jq length)
USERS='[]'
for ((i = 0; i < j; i++)); do
    ID=$(echo "$USER" | ./jq -r ".[$i].UserDirectory.id")
    NEWUSER=$(bash "${MYPATH}/../SmUserDirectories/id2path.sh" "$ID" | ./jq '.[0]')
    NU=$(echo "$USER" | ./jq --argjson u "$NEWUSER" ".[$i] | .UserDirectory = \$u")
    USERS=$(echo "$USERS" | ./jq --argjson u "$NU" '. += [ $u ]')
done
POLICY=$(echo "${POLICY}" | ./jq --argjson u "$USERS" '. + { SmUserPolicies: $u}')
EO=$(echo "$DATA" | ./jq '.EncryptionOptions')
EC=$(echo "$EO" | ./jq '.EncryptionConfiguration')
ID=$(echo "$EC" | ./jq -r '.EncryptionCertificate.id')
CERT=$(bash "$MYPATH/../FedCertificates/id2path.sh" "$ID" | ./jq '.[0]') 
EC=$(echo "$EC" | ./jq --argjson c "$CERT" '. + { EncryptionCertificate: $c }')
EO=$(echo "$EO" | ./jq --argjson ec "$EC" ' . + { EncryptionConfiguration: $ec }')
echo "$DATA" | \
    ./jq --argjson p "$POLICY" --argjson eo "$EO" \
        '. + {Policy: $p, EncryptionOptions: $eo }' | \
    ./jq -f jqlib/rmIHD.jq
