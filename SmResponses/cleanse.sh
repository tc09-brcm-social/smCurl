#!/bin/bash
MYPATH=$(dirname "$0")
DATA=$(cat)
RATTR=$(echo "${DATA}" | ./jq '.SmResponseAttrs')
j=$(echo "$RATTR" | ./jq length)
RATTRS='[]'
for ((i = 0; i < j; i++)); do
    ID=$(echo "$RATTR" | ./jq -r ".[$i].AgentTypeAttrLink.id")
    ATALINKPATH=$(bash "${MYPATH}/../objects/id2path.sh" "$ID" | ./jq '.[0]')
    NA=$(echo "$RATTR" | ./jq --argjson u "$ATALINKPATH" ".[$i] | .AgentTypeAttrLink = \$u")
    RATTRS=$(echo "$RATTRS" | ./jq --argjson u "$NA" '. += [ $u ]')
done
# debug - echo $RATTRS | ./jq '.'
echo "$DATA" | ./jq --argjson u "$RATTRS" '.SmResponseAttrs = $u' | \
    ./jq -f jqlib/rmIHD.jq
