#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
ID=$2
EXIST=$(bash "${MYPATH}/exist.sh" "$ID")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    ./jq -n '. + []'
    exit "$STATUS"
fi
RESP=$(echo "$EXIST" | ./jq -r '.responseType')
if [ "$RESP" == "object" ]; then
    OBJNAME=$(echo "$EXIST" | ./jq -r ".data.${NAME}")
    OBJNAME=$(bash ${MYPATH}/../utils/escName.sh "$OBJNAME")
#    OBJPATH=$(echo "$EXIST" | ./jq '.parent.path + "/" + .data.type + "s/" + '"$OBJNAME")
    OBJPATH=$(echo "$EXIST" | ./jq -r '.parent.path + "/" + .data.type + "s/"')${OBJNAME}
    echo "\"$OBJPATH\"" | ./jq " [ { path: . } ]"
fi
if [ "$RESP" == "links" ]; then
    DATA=$(echo "$EXIST" | ./jq '.data')
    if [ "$DATA" == "null" ]; then
        >&2 echo "$NAME does not exist."
        ./jq -n '. + []'
        exit 1
    fi
    echo "$DATA" | ./jq '[.[]| .path]'
fi
