#!/bin/bash
FILTER=$1
ATTR=$2
DIRNAME=$(cd $(dirname $0); pwd)
cd ../..
. "${DIRNAME}/env.shlib"
checkLDAPClient
setLDAPServer
ldapsearch -h "${LDAPHOST}" -D "${BINDDN}" $BINDPWD -b "${BASEDN}" -s sub "(${FILTER})" "${ATTR}"
# "(${FILTER})" the paratheses surround filter is meant to 
# avoid the default objectclass=* filter to be used for the search
