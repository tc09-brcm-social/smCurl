#!/bin/bash
MYPATH=`dirname $0`
NAME=$1
CHILD=$2
EXIST=`bash "${MYPATH}/exist.sh" "$NAME" "$CHILD"`
if [[ $? != 0 ]]; then
    ./jq -n '. + []'
    exit 1
fi
RESP=`echo "$EXIST" | ./jq -r '.responseType'`
if [ "$RESP" == "object" ]; then
    OBJPATH=`echo "$EXIST" | ./jq '.parent.path + "/" + .data.type + "s/" + .data.Name'`
    echo "$OBJPATH" | ./jq " [ { path: . } ]"
fi
if [ "$RESP" == "links" ]; then
    echo "$EXIST" | ./jq '.data | [.[]| { path: .path} ]'
fi
