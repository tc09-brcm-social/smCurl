#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib "${MYPWD}"
if ! EXIST=$(bash FedOIDCClients/exist.sh "$CLIENTNAME") ; then
    >&2 echo "OIDC Client $CLIENTNAME does not exist"
else
    >&2 echo "*** OIDC Exercising URLs are"
    CALLBACK=$(echo "$EXIST" | ./jq -r '.data.RedirectURI')
    >&2 echo "Test-Only Init URL:" $(echo "$CALLBACK" | sed 's#authcallback#auth/test#')
    >&2 echo "SSO Init URL:" $(echo "$CALLBACK" | sed 's#authcallback#auth/sso#')
    >&2 echo "User Linking Init URL:" $(echo "$CALLBACK" | sed 's#authcallback#auth/link#')
    >&2 echo "***"
    >&2 echo "*** Additional accounts that have email addresses are required."
fi
