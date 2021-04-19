#!/bin/bash
FILE=$1
DIRNAME=$(cd $(dirname $0); pwd)
cd ../..
. "${DIRNAME}/env.shlib"
checkLDAPClient
setLDAPServer
FILE=$(absfile "$FILE")
ldapadd -h "${LDAPHOST}" -c -x -D "${BINDDN}" $BINDPWD -f "$FILE"
