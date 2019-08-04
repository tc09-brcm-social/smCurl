#!/bin/bash
MYPATH=`dirname $0`
ID=$1
EXIST=`bash "${MYPATH}/../objects/exist.sh" "$ID"`
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
