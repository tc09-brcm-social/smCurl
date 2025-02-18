#!/bin/bash
MYPATH=$(dirname "$0")
DATA=$(cat)
USER=$(echo "${DATA}" | ./jq '.SmUserPolicies')
RULE=$(echo "${DATA}" | ./jq '.SmPolicyLinks')
j=$(echo "$USER" | ./jq length)
USERS='[]'
for ((i = 0; i < j; i++)); do
    ID=$(echo "$USER" | ./jq -r ".[$i].UserDirectory.id")
    NEWUSER=$(bash "${MYPATH}/../SmUserDirectories/id2path.sh" "$ID" | ./jq '.[0]')
    NU=$(echo "$USER" | ./jq --argjson u "$NEWUSER" ".[$i] | .UserDirectory = \$u")
    USERS=$(echo "$USERS" | ./jq --argjson u "$NU" '. += [ $u ]')
done
# echo debug - "$USERS" | ./jq '.'
RULES='[]'
j=$(echo "$RULE" | ./jq length)
for ((i = 0; i < j; i++)); do
    ID=$(echo "$RULE" | ./jq -r ".[$i].RuleLink.id")
    NEWRULE=$(bash "${MYPATH}/../SmRules/id2path.sh" "$ID" | ./jq '.[0]')
    ID=$(echo "$RULE" | ./jq -r ".[$i].ResponseLink.id")
    NEWRSP=$(bash "${MYPATH}/../SmResponses/id2path.sh" "$ID" 2>/dev/null |./jq '.[0]')
    GRPID=$(echo "$RULE" | ./jq -r ".[$i].ResponseGroupLink.id")
    NEWGRP=$(bash "${MYPATH}/../SmResponseGroups/id2path.sh" "$GRPID" 2>/dev/null |./jq '.[0]')
    if [[ "$NEWGRP" == "null" ]]; then
	if [[ "$NEWRSP" == "null" ]]; then
            NR=$(echo "$RULE" | 
            ./jq --argjson r "$NEWRULE" --argjson p "$NEWRSP" \
                ".[$i] | .RuleLink = \$r")
	else
            NR=$(echo "$RULE" | 
            ./jq --argjson r "$NEWRULE" --argjson p "$NEWRSP" \
                ".[$i] | .RuleLink = \$r | .ResponseLink = \$p")
	fi
    else
        NR=$(echo "$RULE" | 
            ./jq --argjson r "$NEWRULE" --argjson p "$NEWGRP" \
                ".[$i] | .RuleLink = \$r | .ResponseGroupLink = \$p")
    fi
    RULES=$(echo "$RULES" | ./jq --argjson r "$NR" '. += [ $r ]')
done
# echo debug "$RULES" | ./jq '.'
if [[ ! "$USER" == "null" ]]; then
    DATA=$(echo "$DATA" | ./jq --argjson u "$USERS" '.SmUserPolicies = $u')
fi
if [[ ! "$RULE" == "null" ]]; then
    DATA=$(echo "$DATA" | ./jq --argjson r "$RULES" '.SmPolicyLinks = $r')
fi
echo "$DATA" | ./jq -f jqlib/rmIHD.jq
