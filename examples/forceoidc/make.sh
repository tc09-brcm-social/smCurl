#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib "${MYPWD}"
if ! EXIST=$(bash FedOIDCAdminConfigs/exist.sh "$APNAME") ; then
    >&2 echo "Getting ready to create Authorization Provider $APNAME"
    if ! EXIST=$(bash SmUserDirectories/exist.sh "$APUD") ; then
        >&2 echo "Required User Directory $APUD does not exist, quitting ..."
        exit 1
    fi
    if ! EXIST=$(bash FedCertificates/exist.sh "$APSCERT") ; then
        >&2 echo "Required Signing Certificate $APSCERT does not exist."
        >&2 echo "    Creating a self-signed Certificate ..."
        bash FedCertificates/ext/selfsigned.sh "$APSCERT" "$APSHOST"
    fi
    JSON=$$.json
    bash "$APTEMP" "$APNAME" "$APUD" "$APSCERT" "$APBASEURL" "$APAUTHURL" | \
        ./jq '.SignUserInfo=false' > "$JSON"
    EXIST=$(bash FedOIDCAdminConfigs/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
if ! EXIST=$(bash FedOIDCClients/exist.sh "$CLIENTNAME") ; then
    >&2 echo "Getting ready to create OIDC Client $CLIENTNAME"
    JSON=$$.json
    bash "$CLIENTTEMP" "$CLIENTNAME" "$APNAME" "$TENANT" "$URLSUFFIX" \
        > "$JSON"
    EXIST=$(bash FedOIDCClients/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
>&2 echo "*** Use the following Information "
>&2 echo "*** to configure force.com Auth. Provider:"
ISSUER=$(echo "$EXIST"| ./jq -r '.data.Endpoints.Token' | sed 's#/token$##')
echo "$EXIST" | >&2 ./jq --arg issuer "$ISSUER" --arg suffix "$URLSUFFIX" '{
    "URL Suffix": $suffix,
    "Consumer Key": .data.ClientID,
    "Consumer Secret": .data.ClientSecret,
    "URLs": '.data.Endpoints',
    "Token Issuer": $issuer,
    "Default Scopes": .data.Scopes,
    "Send access token in header": true,
    "Send client credentials in header": false,
    "Include Consumer Secret in API Responses": true,
    "Callback URL": .data.RedirectURI }'
