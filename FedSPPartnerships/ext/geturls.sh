#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
NAME=$1
if ! EXIST=$(bash "$MYPATH"/../exist.sh "$NAME") ; then
    exit 1
fi
STATUS=$(echo "$EXIST" | ./jq -r '.data.Status')
RSP=$(echo "$EXIST" | ./jq -r '.data.RemoteSPEntityName')
if ! SP=$(bash FedSPRemotes/exist.sh "$RSP") ; then
    >&2 echo "Warning: System error!"
    exit 1
fi
SPID=$(echo "$SP" | ./jq -r '.data.SPID')
echo "$EXIST" | ./jq --arg s "$SPID" '
    { "Name" : .data.Name
     ,"Status" : .data.Status
     ,"IdPInitiatedURL" : (.data.BaseURL
         + "/affwebservices/public/saml2sso?SPID="
         + $s)
    }
'
if [[ ! "$STATUS" = "Active" ]] ; then
    echo '***' "Warning IdP->SP $NAME has not been activated."
    echo '***' It needs to be activated for the IdPInitiatedURL to work.
fi
