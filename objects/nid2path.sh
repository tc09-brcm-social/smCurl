#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
ID=$2
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$ID"); then
    STATUS=$?
    ./jq -n '. + []'
    exit "$STATUS"
fi
RESP=$(echo "$EXIST" | ./jq -r '.responseType')
if [ "$RESP" == "object" ]; then
    VALUE=$(echo "$EXIST" | ./jq ".data.${NAME}")
    OBJPATH=$(echo "$EXIST" | ./jq '.parent.path + "/" + .data.type + "s/" + '"$VALUE")
    OBJPATH=$(bash ${MYPATH}/../utils/escName.sh "$OBJPATH")
    echo "$OBJPATH" | ./jq " [ { path: . } ]"
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
