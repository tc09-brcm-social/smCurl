#!/bin/bash
#add give an existing Agent Group an additional Agent
MYPATH=`dirname $0`
SMCONTAINER=$1
CONTAINERTYPE=SmAgentGroups
SMOBJECT=$2
OBJTYPE=SmAgents
OBJLINK=AgentsLink
SMOBJ=/${OBJTYPE}/$SMOBJECT
EXIST=`bash "$OBJTYPE"/exist.sh "$SMOBJECT"`
if [[ "$?" != 0 ]]; then
    exit 1
fi
READCONTAINER=`bash "${MYPATH}/exist.sh" "$SMCONTAINER"`
if [[ "$?" != 0 ]]; then
    exit 1
fi
OBJPATH=`echo "$READCONTAINER" | ./jq "select(.data.${OBJLINK} != null) | .data.${OBJLINK}[] | select(.path | contains(\"${SMOBJ}\"))"`
if [ -z "$OBJPATH" ]; then
    JSON=$$.json
    echo "$READCONTAINER" | ./jq ".data | .${OBJLINK} += [ { path: \"${SMOBJ}\"} ]" > "$JSON"
    bash "${MYPATH}/update.sh" "$SMCONTAINER" "$JSON"
else
    echo "$SMOBJECT has been in $SMCONTAINER"
fi
