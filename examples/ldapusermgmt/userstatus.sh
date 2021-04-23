#!/bin/bash
NAME=$1
DIRNAME=$(cd $(dirname "$0"); pwd)
cd ../..
. "${DIRNAME}/env.shlib"
EXIST=$(bash "SmUserDirectories/ext/getattrs.sh" "$UD"); STATUS=$?
if [[ "$STATUS" != 0 ]]; then
    echo "$EXIST" | ./jq '.'
    exit "$STATUS"
fi
ID=$(echo "$EXIST" | ./jq -r '."Universal ID"')
FLAG=$(echo "$EXIST" | ./jq -r '."Disabled Flag"')
adjustldapud
cd "$LDAPUD"
bash searchldap.sh "$ID=$NAME" "$FLAG" | grep "^$FLAG:" | cut '-d ' -f2
