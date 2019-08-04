#!/bin/bash
#addUD give an existing Domain an additional User Directory
MYPATH=`dirname $0`
SMCONTAINER=$1
CONTAINERTYPE=SmDomains
SMOBJECT=$2
OBJTYPE=SmUserDirectories
OBJLINK=UserDirectoriesLink
SMOBJ=/${OBJTYPE}/$SMOBJECT
EXIST=`bash "$OBJTYPE"/exist.sh "$SMOBJECT"`
if [[ "$?" != 0 ]]; then
    exit 1
fi
READCONTAINER=`bash "${MYPATH}/exist.sh" "$SMCONTAINER"`
if [[ "$?" != 0 ]]; then
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
