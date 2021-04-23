#!/bin/bash
NAME=$1
DIRNAME=$(cd $(dirname "$0"); pwd)
STATE=$(bash "$DIRNAME/userstatus.sh" "$NAME")
if [[ -z "$STATE" ]] ; then
    STATE=1
fi
cd ../..
SSOHOME=$(pwd)
. "${DIRNAME}/env.shlib"
adjustldapud

. SmUserDirectories/ext/env.shlib
EXIST=$(bash "SmUserDirectories/ext/getattrs.sh" "$UD"); STATUS=$?
if [[ "$STATUS" != 0 ]]; then
    echo "$EXIST" | ./jq '.'
    exit "$STATUS"
fi
UIDATTR=$(echo "$EXIST" | ./jq -r '."Universal ID"')
DISABLEATTR=$(echo "$EXIST" | ./jq -r '."Disabled Flag"')
cd "$LDAPUD"
DN=$(bash jsondn.sh "${UIDATTR}=${NAME}" | "${SSOHOME}/jq" -r '.[0]')
LDIF=$$.ldif
bash "./moduser.temp" "$DN" "${DISABLEATTR}" "$((${Disable} | $STATE))" >> "${SSOHOME}/$LDIF"
bash modifyldap.sh "$SSOHOME/$LDIF"
