#!/bin/bash
MYPATH="$(cd "$(dirname "$0")"; pwd)"
NAME=$1
if ! EXIST=$(bash "$MYPATH"/../exist.sh "$NAME") ; then
    exit 1
fi
BASEURL=$(echo "$EXIST" | ./jq -r '.data.BaseURL')
./jq -n --arg s "$BASEURL" \
    '{
        "SOAPArtifactResolution" : ( $s + "/affwebservices/public/saml2ars" )
        , "SSOService" : ( $s + "/affwebservices/public/saml2sso" )
        , "SLOService" : ( $s + "/affwebservices/public/saml2slo" )
        , "SLOSOAPService" : ( $s + "/affwebservices/public/saml2slosoap" )
        , "UserConsentService" : ( $s + "/affwebservices/public/saml2userconsent" )
        , "AttributeService" : ( $s + "/affwebservices/public/saml2attrsvc" )
        , "SOAPManageNameIDService" : ( $s + "/affwebservices/public/saml2nidsoap" )
    }'
