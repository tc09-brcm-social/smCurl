#!/bin/bash
SPEC=$1
DIRNAME=$(cd $(dirname $0); pwd)
cd ../..
SSOHOME=$(pwd)
. "$DIRNAME/env.shlib"
checkLDAPClient
setLDAPServer
cd "$DIRNAME"
LIST=$(bash jsondn.sh "$SPEC")
LEN=$(echo "$LIST" | "${SSOHOME}/jq" length)
for (( i = 0; i < $LEN; ++i)) ; do
    DN=$(echo "$LIST" | "${SSOHOME}/jq" -r ".[$i]")
    ldapdelete -h "${LDAPHOST}" -D "${BINDDN}" $BINDPWD "$DN"
done
