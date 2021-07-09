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
CONTAINER=$(echo "$PARENT" | ./jq --arg a "$ONECHILD" 'select (.data.UserDirectoriesLink != null) | [ .data.UserDirectoriesLink[] | select(.path == $a) ]')
JSON=$$.json
if [[ -z "$CONTAINER" || $(echo "$CONTAINER" | ./jq 'length') -eq "0" ]]; then
    CONTAINER=$(echo "$PARENT" | ./jq --arg a "$ONECHILD" 'select (.data.UserDirectoriesLink != null) | [ .data.UserDirectoriesLink[] | select(.path != $a) ]')
    if [[ -z "$CONTAINER" ]]; then
	./jq -n --argjson a "$CHILDPATH" '{ "UserDirectoriesLink": $a }' \
	> "$JSON"
    else
        echo "$CONTAINER" | \
        ./jq --argjson a "$CHILDPATH" '. + $a | { "UserDirectoriesLink": . }' \
        > "$JSON"
    fi
    bash "SmDomains/update.sh" "$NAME" "$JSON"
else
    >&2 echo "User Directory $CHILD is in the $NAME Domain" already, skipped
fi
