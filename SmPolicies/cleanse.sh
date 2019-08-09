#!/bin/bash
MYPATH=$(dirname "$0")
DATA=$(cat)
USER=$(echo "${DATA}" | ./jq '.SmUserPolicies')
RULE=$(echo "${DATA}" | ./jq '.SmPolicyLinks')
j=$(echo "$RULE" | ./jq length)
USERS='[]'
for ((i = 0; i < j; i++)); do
    ID=$(echo "$USER" | ./jq -r ".[$i].UserDirectory.id")
    NEWUSER=$(bash "${MYPATH}/../SmUserDirectories/id2path.sh" "$ID" | ./jq '.[0]')
    NU=$(echo "$USER" | ./jq --argjson u "$NEWUSER" ".[$i] | .UserDirectory = \$u")
    USERS=$(echo "$USERS" | ./jq --argjson u "$NU" '. += [ $u ]')
done
# debug - echo $USERS | ./jq '.'
RULES='[]'
j=$(echo "$USER" | ./jq length)
for ((i = 0; i < j; i++)); do
    ID=$(echo "$RULE" | ./jq -r ".[$i].RuleLink.id")
    NEWRULE=$(bash "${MYPATH}/../objects/id2path.sh" "$ID" | ./jq '.[0]')
    NR=$(echo "$RULE" | ./jq --argjson r "$NEWRULE" ".[$i] | .RuleLink = \$r")
    RULES=$(echo "$RULES" | ./jq --argjson r "$NR" '. += [ $r ]')
done
#debug - echo $RULES | ./jq '.'
echo "$DATA" | ./jq --argjson u "$USERS" '.SmUserPolicies = $u' | \
    ./jq --argjson r "$RULES" '.SmPolicyLinks = $r' | ./jq -f jqlib/rmIHD.jq
