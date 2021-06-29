#!/bin/bash
NAME=$1
NEWPWD=$2
DIRNAME=$(cd $(dirname "$0"); pwd)
cd ../..
SSOHOME=$(pwd)
. "${DIRNAME}/env.shlib" "${DIRNAME}"
. SmUserDirectories/ext/env.shlib
EXIST=$(bash "SmUserDirectories/ext/getattrs.sh" "$UD"); STATUS=$?
if [[ "$STATUS" != 0 ]]; then
    echo "$EXIST" | ./jq '.'
    exit "$STATUS"
fi
UIDATTR=$(echo "$EXIST" | ./jq -r '."Universal ID"')
PWDATTR=$(echo "$EXIST" | ./jq -r '."Password"')
cd "$LDAPUD"
DN=$(bash jsondn.sh "${UIDATTR}=${NAME}" | "${SSOHOME}/jq" -r '.[0]')
LDIF=$$.ldif
bash "./moduser.temp" "$DN" "${PWDATTR}" "$NEWPWD" >> "${SSOHOME}/$LDIF"
bash modifyldap.sh "$SSOHOME/$LDIF"
