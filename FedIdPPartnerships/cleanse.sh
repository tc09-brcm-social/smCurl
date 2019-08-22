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
echo "$DATA" | \
    ./jq --argjson p "$POLICY" '. + {Policy: $p}' | \
    ./jq -f jqlib/rmIHD.jq
