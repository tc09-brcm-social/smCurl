#!/bin/bash
#
# This script makes the SMHCO, SMAGENT, and SMACO needed before the Access Gateway
# configuration wizard.
#
MYPWD=$(pwd)
cd ../wa
WAPWD=$(pwd)
. ${MYPWD}/env.shlib >> env.shlib
bash make.sh
cd "${WAPWD}"
. ./env.shlib
cd ../..
SMACO=$WAACO
if EXIST=$(bash SmAgentConfigs/exist.sh "$SMACO"); then
    JSON=$$.json
    echo "$EXIST" | ./jq '.data' | bash SmAgentConfigs/cleanse.sh | \
        bash SmAgentConfigs/jsetattr.sh LogoffUri '%2Fproxyui%2Flogout' | \
        bash SmAgentConfigs/jaddattr.sh LogoffUri '%2Flogout.html' | \
        bash SmAgentConfigs/jaddattr.sh LogoffUri '%2Flogoff%2Flogoff.html' | \
        bash SmAgentConfigs/jsetattr.sh AgentWaitTime '5' | \
        bash SmAgentConfigs/jsetattr.sh AllowLocalConfig 'yes' | \
        bash SmAgentConfigs/jsetattr.sh AutoAuthorizeHttpMethods 'HEAD%03OPTIONS' | \
        bash SmAgentConfigs/jsetattr.sh BadUrlChars '%2F%2F%2C.%2F%2C%2F%2A%2C%2A.%2C~%2C%5C%2C%2500-%251f%2C%257f' \
        > "$JSON"
    EXIST=$(bash SmAgentConfigs/update.sh "$SMACO" "$JSON")
fi
echo "$EXIST" | ./jq '.data'
