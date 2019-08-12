#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
bash "${MYPATH}/jrmaction.sh" "$NAME" | \
    ./jq --arg a "$NAME" '.Actions += [$a]'
