#!/bin/bash
#
# This script makes the SMHCO, SMAGENT, and SMACO needed before the Access Gateway
# configuration wizard.
#
MYPWD=$(pwd)
. ./env.shlib
cd ../..
#
# HCO for Access Gateway
#
SMHCO=$SPSHCO
if ! EXIST=$(bash SmHostConfigs/exist.sh "$SMHCO"); then
    SMPSHOST=$SPSPSHOST
    JSON=$$.json
    bash SmHostConfigs/temp/hco.temp "$SMHCO" "$SMPSHOST" >"$JSON"
    EXIST=$(bash SmHostConfigs/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
#
# Agent for Access Gateway
#
SMAGENT=$SPSAGENT
if ! EXIST=$(bash SmAgents/exist.sh "$SMAGENT"); then
    SMAGENTTEMP=SmAgents/temp/agent.temp
    JSON=$$.json
    bash "$SMAGENTTEMP" "$SMAGENT" >"$JSON"
    EXIST=$(bash SmAgents/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
#
# ACO for Access Gateway
#
SMACO=$SPSACO
if ! EXIST=$(bash SmAgentConfigs/exist.sh "$SMACO"); then
    SMACOTEMP=${MYPWD}/acoSPS1.temp
    JSON=$$.json
    bash "$SMACOTEMP" "$SMACO" "$SMAGENT" "$SPSDEF" >"$JSON"
    EXIST=$(bash SmAgentConfigs/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
