#!/bin/bash
MYPATH=`dirname $0`
NAME=$1
CHILD=$2
LIST=`bash "${MYPATH}/list.sh" "$NAME" "$CHILD"`
if [[ $? != 0 ]]; then
    ./jq -n '. + []'
    exit 1
fi
echo "$LIST" | ./jq '[.[]| { path: .} ]'
