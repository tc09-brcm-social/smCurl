#!/bin/bash
#addUD give an existing Domain an additional User Directory
MYPATH=$(dirname "$0")
SMCONTAINER=$1
CONTAINERTYPE=SmDomains
SMOBJECT=$2
OBJTYPE=SmUserDirectories
OBJLINK=UserDirectoriesLink
SMOBJ=/${OBJTYPE}/$SMOBJECT
EXIST=$(bash "$OBJTYPE"/exist.sh "$SMOBJECT"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then 
    echo "$EXIST"
    exit "$STATUS"
fi
READCONTAINER=$(bash "${MYPATH}/exist.sh" "$SMCONTAINER"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$READCONTAINER"
    exit "$STATUS"
fi
OBJPATH=$(echo "$READCONTAINER" | ./jq "select(.data.${OBJLINK} != null) | .data.${OBJLINK}[] | select(.path | contains(\"${SMOBJ}\"))")
if [ -z "$OBJPATH" ]; then
    JSON=$$.json
    echo "$READCONTAINER" | ./jq ".data | .${OBJLINK} += [ { path: \"${SMOBJ}\"} ]" > "$JSON"
    bash "${MYPATH}/update.sh" "$SMCONTAINER" "$JSON"
else
    >&2 echo "$SMOBJECT has been in $SMCONTAINER"
fi
