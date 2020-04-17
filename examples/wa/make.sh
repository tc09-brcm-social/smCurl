#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
if [ -z "$WAACOTEMP" ] && [ -z "$WAACODEF" ]; then
    echo "Error: need to have value for WAACOTEMP or WAACODEF"
    exit 1
fi
cd ../..
#
# HCO for WA
#
SMHCO=$WAHCO
if ! EXIST=$(bash SmHostConfigs/exist.sh "$SMHCO"); then
    SMPSHOST=$WAPSHOST
    JSON=$$.json
    bash SmHostConfigs/temp/hco.temp "$SMHCO" "$SMPSHOST" >"$JSON"
    EXIST=$(bash SmHostConfigs/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
#
# Agent: WAAGENT
#
SMAGENT=$WAAGENT
if ! EXIST=$(bash SmAgents/exist.sh "$SMAGENT"); then
    SMAGENTTEMP=SmAgents/temp/agent.temp
    JSON=$$.json
    bash "$SMAGENTTEMP" "$SMAGENT" >"$JSON"
    EXIST=$(bash SmAgents/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
#
# ACO - WAACO
#
SMACO=$WAACO
if ! EXIST=$(bash SmAgentConfigs/exist.sh "$SMACO"); then
    JSON=$$.json
    if [ ! -z "$WAACODEF" ] && \
        EXIST=$(bash SmAgentConfigs/exist.sh "$WAACODEF"); then
        echo "$EXIST" | ./jq '.data' | bash "SmAgentConfigs/cleanse.sh" | \
            bash SmAgentConfigs/jsetattr.sh DefaultAgentName "$SMAGENT" | \
            ./jq -S --arg n "${SMACO}" '. + {"Name": $n,
                 "Desc": ("made using " + .Name + " plus other additions")}' \
	    > "$JSON"
    else
        if [ ! -z "$WAACOTEMP" ]; then
	    bash "$WAACOTEMP" "$SMACO" "$SMAGENT" > "$JSON"
	else
            >&2 echo -n "Error: unable to create ACO using " \
            >&2 echo "the ACO template: \"$WAACOTEMP\" and example: \"$WAACODEF\"."
            exit 1
        fi
    fi
    EXIST=$(bash SmAgentConfigs/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
