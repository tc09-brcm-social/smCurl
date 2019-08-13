#!/bin/bash
#addUD give an existing Domain an additional User Directory
MYPATH=$(dirname "$0")
SMCONTAINER=$1
CONTAINERTYPE=SmDomains
SMOBJECT=$2
OBJTYPE=SmUserDirectories
OBJLINK=UserDirectoriesLink
SMOBJ=/${OBJTYPE}/$SMOBJECT
if ! EXIST=$(bash "$OBJTYPE"/exist.sh "$SMOBJECT"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
if ! READCONTAINER=$(bash "${MYPATH}/exist.sh" "$SMCONTAINER"); then
    STATUS=$?
    echo "$READCONTAINER"
    exit "$STATUS"
fi
OBJPATH=$(echo "$READCONTAINER" | ./jq "select(.data.${OBJLINK} != null) | .data.${OBJLINK}[] | select(.path | contains(\"${SMOBJ}\"))")
if [ -z "$OBJPATH" ]; then
    JSON=$$.json
    echo "$READCONTAINER" | ./jq ".data | .${OBJLINK} += [ { path: \"${SMOBJ}\"} ]" > "$JSON"
    bash "${MYPATH}/update.sh" "$SMCONTAINER" "$JSON"
else
    2> echo "$SMOBJECT has been in $SMCONTAINER"
fi
