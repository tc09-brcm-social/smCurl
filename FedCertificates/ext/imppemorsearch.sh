#!/bin/bash
ALIAS=$1
FNAME=$2
MYPATH=$(dirname "$0")
EXIST=$(bash "$MYPATH/../exist.sh" "$ALIAS"); STATUS=$?
if [[ "$STATUS" -eq 0 ]] ; then
    ALIAS="$ALIAS$(date +"%Y%m%d%N")"
fi
EXIST=$(bash "$MYPATH/../imppem.sh" "$ALIAS" "$FNAME")
if [[ "$(echo "$EXIST" | ./jq -r '.status')" == "400" ]] ; then
    ALIAS=$(bash "$MYPATH/search.sh" "$FNAME")
fi
echo $ALIAS
