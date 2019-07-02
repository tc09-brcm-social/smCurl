#!/bin/bash
#addUD2Domain give an existing Domain an additional User Directory
MYPATH=`dirname $0`
SMCONTAINER=$1
CONTAINERTYPE=SmDomains
SMOBJECT=$2
OBJTYPE=SmUserDirectories
OBJLINK=UserDirectoriesLink
SMOBJ=/${OBJTYPE}/$SMOBJECT
OBJECT=`bash "$OBJTYPE"/read.sh "$SMOBJECT" | ./jq '.responseType'`
if [ "$OBJECT" == "\"error\"" ]; then
    echo "$OBJTYPE $SMOBJECT does not exist."
    exit 1
fi
READCONTAINER=`bash "${MYPATH}/read.sh" "$SMCONTAINER"`
CONTAINER=`echo "$READCONTAINER" | ./jq '.responseType'`
if [ "$CONTAINER" == "\"error\"" ]; then
    echo "$CONTAINERTYPE $SMCONTAINER does not exist."
    exit 1
fi
OBJPATH=`echo "$READCONTAINER" | ./jq ".data.${OBJLINK}[] | select(.path | contains(\"${SMOBJ}\"))"`
if [ -z "$OBJPATH" ]; then
    JSON=$$.json
    echo "$READCONTAINER" | ./jq ".data | .${OBJLINK} += [ { path: \"${SMOBJ}\"} ]" > "$JSON"
    bash "${MYPATH}/update.sh" "$SMCONTAINER" "$JSON"
else
    echo "$SMOBJECT has been in $SMCONTAINER"
fi
