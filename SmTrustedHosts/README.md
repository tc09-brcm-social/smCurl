SUPPORT It may not be as useful to manipulate the SmTrustHosts using RestAPI at all.
* delete.sh TrustHostName -- delete a Trusted Host
* exist.sh TrustedHostName -- check if the TrustedHost exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh TrustedHostNameSpec -- list the existing trusted hosts in JSON array
** prints out empty array if exist.sh fails
* read.sh TrustedHostSpec  -- GET the trusted hosts
