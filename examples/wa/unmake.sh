#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
#
# HCO for WA
#
SMHCO=$WAHCO
if ! EXIST=$(bash SmHostConfigs/exist.sh "$SMHCO"); then
    >&2 echo "HCO $SMHCO does not exist, skipped"
else
    >&2 echo "removing HCO $SMHCO"
    bash SmHostConfigs/delete.sh "$SMHCO"
fi
#
# Agent: WAAGENT
#
SMAGENT=$WAAGENT
if ! EXIST=$(bash SmAgents/exist.sh "$SMAGENT"); then
    >&2 echo "SmAgent $SMAGENT does not exist, skipped"
else
    >&2 echo "removing SmAgent $SMAGENT"
    bash SmAgents/delete.sh "$SMAGENT"
fi
#
# ACO - WAACO
#
SMACO=$WAACO
if ! EXIST=$(bash SmAgentConfigs/exist.sh "$SMACO"); then
    >&2 echo "ACO $SMACO does not exist, skipped"
else
    >&2 echo "removing ACO $SMACO"
    bash SmAgentConfigs/delete.sh "$SMACO"
fi
