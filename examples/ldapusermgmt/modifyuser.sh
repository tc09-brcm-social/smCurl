#!/bin/bash
NAME=$1
ATTR=$2
VALUE=$3
DIRNAME=$(cd $(dirname "$0"); pwd)
cd ../..
MYHOME=$(pwd)
. "${DIRNAME}/env.shlib" "${DIRNAME}"
cd "$DIRNAME"
DN=$(bash "${DIRNAME}/searchuser.sh" "$NAME" | awk -f "${DIRNAME}/ldif2json.awk" | "${MYHOME}/jq" -r '.[0].dn')
LDIF=$$.ldif
bash "${LDAPUD}/moduser.temp" "$DN" "$ATTR" "$VALUE" > "${MYHOME}/${LDIF}"
cd "$LDAPUD"
bash modifyldap.sh "${MYHOME}/${LDIF}"
