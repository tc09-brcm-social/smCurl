#!/bin/bash
#nmACO.sh normalize an existing ACO
SMACO=$1
SMACOBASE=`bash readACO.sh "$SMACO" | ./jq '.data | del(.Attributes)' | sed '$d'`
SMACOATTR=`bash readACO.sh "$SMACO" | ./jq '.data.Attributes' |  sed '1d' |sed '$d' | sort | sed 's/"$/",/' | sed '$s/,$//'`
echo "${SMACOBASE}" ", \"Attributes\" : [" "${SMACOATTR}" '] }' | ./jq '.'
