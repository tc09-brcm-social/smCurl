#!/bin/bash
NAME=$1
MYPATH=`dirname $0`
EXIST=`bash "${MYPATH}/exist.sh" "$NAME"`
if [[ $? != 0 ]]; then
    ./jq -n '. + []'
    exit 1
fi
RESP=`echo "$EXIST" | ./jq -r '.responseType'`
if [ "$RESP" == "object" ]; then
    echo "$EXIST" | ./jq '[ .parent.path + "/" + .data.type + "s/" + .data.Name]'
fi
if [ "$RESP" == "links" ]; then
    echo "$EXIST" | ./jq '.data | [.[]| .path]'
fi
