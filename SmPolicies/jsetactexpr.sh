#!/bin/bash
MYPATH=$(dirname "$0")
LIB=$1
FUNC=$2
PARM=$3
./jq --arg l "$LIB" --arg f "$FUNC" --arg p "$PARM" \
    '.ActiveExprString = ("<@lib=\"" + $l + "\" func=\"" + $f + "\" param=\"" + $p + "\"@>")'
