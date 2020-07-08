#!/bin/bash
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
    exit 0
fi
READCONTAINER=$(bash "${MYPATH}/exist.sh" "$SMCONTAINER"); STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$READCONTAINER"
    exit 0
fi
JSON=$$.json
echo "$READCONTAINER" |  ./jq ".data.$OBJLINK | { \"$OBJLINK\" : .}" |\
    bash SmDomains/cleanse.sh | \
    ./jq "[ .$OBJLINK[]|select (.path != \"/$OBJTYPE/$SMOBJECT\") ] | {\"$OBJLINK\": .}" > "$JSON"
bash "$MYPATH/update.sh" "$SMCONTAINER" "$JSON"
