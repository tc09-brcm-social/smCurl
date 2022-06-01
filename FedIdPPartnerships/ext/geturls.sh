#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
NAME=$1
if ! EXIST=$(bash "$MYPATH"/../exist.sh "$NAME") ; then
    exit 1
fi
STATUS=$(echo "$EXIST" | ./jq -r '.data.Status')
RIDP=$(echo "$EXIST" | ./jq -r '.data.RemoteIdPEntityName')
if ! IDP=$(bash FedIdPRemotes/exist.sh "$RIDP") ; then
    >&2 echo '***' "Warning: System error!"
    exit 1
fi
IDPID=$(echo "$IDP" | ./jq -r '.data.IdPID')
echo "$EXIST" | ./jq --arg s "$IDPID" '
    { "Name" : .data.Name
     ,"Status" : .data.Status
     ,"SPInitiatedURL" : (.data.BaseURL
         + "/affwebservices/public/saml2authnrequest?ProviderID="
         + $s)
    }
'
if [[ ! "$STATUS" = "Active" ]] ; then
    >&2 echo '***' "Warning SP->IdP $NAME has not been activated."
    >&2 echo '*** It needs to be activated for the SPInitiatedURL to work.'
fi
