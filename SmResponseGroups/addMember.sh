#!/bin/bash
# addMember give an existing ResponseGroup an additional Member
SMDOMAIN=$1
SMGROUP=$2
SMMEMBER=$3
MEMBER=`bash SmResponses/read.sh "$SMDOMAIN" "$SMMEMBER" | ./jq '.responseType'`
if [ "$MEMBER" == "\"error\"" ]; then
    echo "Response $SMMEMBER does not exist in Domain $SMDOMAIN."
    exit 1
fi
READGROUP=`bash SmResponseGroups/read.sh "$SMDOMAIN" "$SMGROUP"`
GROUP=`echo "$READGROUP" | ./jq '.responseType'`
if [ "$GROUP" == "\"error\"" ]; then
    echo "Response Group $SMGROUP does not exist in Domain $SMDOMAIN."
    exit 1
fi
if echo "$READGROUP" | grep -q "ResponsesLink"; then
    for i in `echo "$READGROUP" | ./jq '.data.ResponsesLink[].path' | awk 'BEGIN {FS="/";} { print $5;}'` ; do
        if [ "$SMMEMBER\"" == "$i" ]; then
	    echo "$SMMEMBER has been in $SMGROUP"
	    exit 0
        fi
    done
fi
echo "adding $SMMEMBER into $SMGROUP"
JSON=$$.json
echo "$READGROUP" | ./jq ".data | .ResponsesLink += [ { path: \"/SmDomain/$SMDOMAIN/SmResponses/$SMMEMBER\" }]" > $JSON
bash SmResponseGroups/update.sh "$SMDOMAIN" "$SMGROUP" "$JSON"
