#!/bin/bash
#nmACO.sh normalize an existing ACO
SMACO=$1
ACO=`bash readACO.sh "$SMACO" | ./jq '.data'`
SORTATTR=`echo "$ACO" | ./jq '.Attributes | sort'`
ACONOATTR=`echo "$ACO" | ./jq 'del(.Attributes)'`
echo "$ACONOATTR" | ./jq -S ". + {Attributes: ${SORTATTR}}"
