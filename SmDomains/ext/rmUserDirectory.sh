#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
if ! PARENT=$(bash "${MYPATH}/../exist.sh" "$NAME") ; then
    >&2 echo "$CHILD does not exist."
    exit 1
fi
if ! EXIST=$(bash "SmUserDirectories/exist.sh" "$CHILD") ; then
    >&2 echo "$CHILD does not exist"
    exit 1
fi
CHILDPATH=$(bash SmUserDirectories/id2path.sh \
    $(echo "$EXIST" | ./jq -r '.data.id'))
ONECHILD=$(echo "$CHILDPATH" | ./jq -r '.[0].path')
CONTAINER=$(echo "$PARENT" | ./jq --arg a "$ONECHILD" '[ .data.UserDirectoriesLink[] | select(.path != $a) ]')
JSON=$$.json
echo "$CONTAINER" | \
    ./jq '{ "UserDirectoriesLink": . }' \
    > "$JSON"
bash "SmDomains/update.sh" "$NAME" "$JSON"
