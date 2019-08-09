#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
VAR=$2
if ! VARPATH=$(bash "${MYPATH}/../SmVariables/listpath.sh" "$NAME" "$VAR"); then
    STATUS=$?
    ./jq '.'
    exit "$STATUS"
fi
./jq --argjson v "$VARPATH" '.VariablesLink += $v'
