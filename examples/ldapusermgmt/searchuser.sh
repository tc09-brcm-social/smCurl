#!/bin/bash
NAME=$1
DIRNAME=$(cd $(dirname "$0"); pwd)
cd ../..
MYHOME=$(pwd)
. "${DIRNAME}/env.shlib" "$DIRNAME"
EXIST=$(bash "SmUserDirectories/ext/getattrs.sh" "$UD"); STATUS=$?
if [[ "$STATUS" != 0 ]]; then
    echo "$EXIST" | "$MYHOME/jq" '.'
    exit "$STATUS"
fi
ID=$(echo "$EXIST" | "$MYHOME/jq" -r '."Universal ID"')
cd "$LDAPUD"
bash searchldap.sh "$ID=$NAME" '*'
