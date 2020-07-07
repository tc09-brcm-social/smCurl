#!/bin/bash
MYPATH=$(dirname "$0")
SMDOMAIN=$1
SMCONTAINER=$2
CONTAINERTYPE=SmResponseGroups
SMOBJECT=$3
OBJTYPE=SmResponses
OBJLINK=ResponsesLink
SMOBJ=/SmDomains/$SMDOMAIN/${OBJTYPE}/$SMOBJECT
EXIST=$(bash "$OBJTYPE"/exist.sh "$SMDOMAIN" "$SMOBJECT")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$EXIST"
    exit "$STATUS"
fi
READCONTAINER=$(bash "${MYPATH}/exist.sh" "$SMDOMAIN" "$SMCONTAINER")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$READCONTAINER"
    exit "$STATUS"
fi
OBJPATH=$(echo "$READCONTAINER" | ./jq "select(.data.${OBJLINK} != null) | .data.${OBJLINK}[] | select(.path | contains(\"${SMOBJ}\"))")
if [ -z "$OBJPATH" ]; then
    JSON=$$.json
    echo "$READCONTAINER" | \
        ./jq ".data | { ${OBJLINK}: .${OBJLINK} } |
	     .${OBJLINK} += [ { path: \"${SMOBJ}\"} ]" > "$JSON"
    READCONTAINER=$(bash "${MYPATH}/update.sh" "$SMDOMAIN" "$SMCONTAINER" "$JSON")
else
    >&2 echo "$SMOBJECT has been in $SMCONTAINER"
fi
echo "$READCONTAINER"
