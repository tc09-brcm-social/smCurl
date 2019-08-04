#!/bin/bash
MYPATH=`dirname $0`
TYPE=$1
ID=$2
EXIST=`bash "${MYPATH}/../objects/exist.sh" "$ID"`
if [[ $? != 0 ]]; then
    ./jq -n '. + []'
    exit 1
fi
RESP=`echo "$EXIST" | ./jq -r '.responseType'`
if [ "$RESP" == "object" ]; then
    OBJPATH=`echo "$EXIST" | ./jq '"/" + "'"$TYPE"'/" + .data.Name'`
    OBJPATH=`bash ${MYPATH}/../utils/escName.sh "$OBJPATH"`
    echo "$OBJPATH" | ./jq " [ { path: . } ]"
fi
if [ "$RESP" == "links" ]; then
    echo "$EXIST" | ./jq '.data | [.[]| { path: .path} ]'
fi
