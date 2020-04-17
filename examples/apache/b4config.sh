#!/bin/bash
MYPWD=$(pwd)
cd ../wa
. "$MYPWD/env.shlib" >> env.shlib
WAPWD=$(pwd)
bash ./make.sh
cd ${WAPWD}
. ./env.shlib
cd ../..
SMACO=$WAACO
if EXIST=$(bash SmAgentConfigs/exist.sh "$SMACO"); then
    JSON=$$.json
    echo "$EXIST" | ./jq '.data' | bash SmAgentConfigs/cleanse.sh | \
        bash SmAgentConfigs/jsetattr.sh LogoffUri '%2Flogout.html' | \
        bash SmAgentConfigs/jaddattr.sh LogoffUri '%2Flogoff%2Flogoff.html' \
        > "$JSON"
    EXIST=$(bash SmAgentConfigs/update.sh "$SMACO" "$JSON")
fi
echo "$EXIST" | ./jq '.data'
