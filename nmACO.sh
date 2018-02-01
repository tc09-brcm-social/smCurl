#!/bin/bash
#nmACO.sh normalize an existing ACO
SMACO=$1
bash readACO.sh "$SMACO" | ./jq -S '.data'
