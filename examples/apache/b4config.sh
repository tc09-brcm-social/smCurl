#!/bin/bash
. ./env.shlib
MYPWD=$(pwd)
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
    SMACOTEMP="$MYPWD/acoApache.temp"
    JSON=$$.json
    bash "$SMACOTEMP" "$SMACO" "$SMAGENT" "$WADEF" > "$JSON"
    EXIST=$(bash SmAgentConfigs/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
