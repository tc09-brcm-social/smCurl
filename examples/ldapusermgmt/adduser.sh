#!/bin/bash
NAME=$1
DIRNAME=$(cd $(dirname "$0"); pwd)
LNAME=$2
FNAME=$3
MAIL=$4
PASS=p$$
cd ../..
SSOHOME=$(pwd)
. "$DIRNAME/env.shlib"
adjustldapud
EXIST=$(bash "SmUserDirectories/ext/getattrs.sh" "$UD"); STATUS=$?
if [[ "$STATUS" != 0 ]]; then
    echo "$EXIST" | ./jq '.'
    exit "$STATUS"
fi
LDIF=$$.ldif
bash "${DIRNAME}/adduser.temp" "$NAME" "$LNAME" "$FNAME" "$MAIL" "$PASS" > "$LDIF"
. SmUserDirectories/ext/env.shlib
echo $(echo "$EXIST" | ./jq -r '."Disabled Flag"'): ${ForcePasswordChange} >> "$LDIF"
cd "${LDAPUD}"
bash addldap.sh "${SSOHOME}/$LDIF"
cd "${DIRNAME}"
bash selfpwdlink.sh "$NAME" "$PASS"
