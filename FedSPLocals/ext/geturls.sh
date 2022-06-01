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
        , "SLOService" : ( $s + "/affwebservices/public/saml2slo" )
        , "SLOSOAPService" : ( $s + "/affwebservices/public/saml2slosoap" )
        , "AssertionConsumerService" : ( $s + "/affwebservices/public/saml2assertionconsumer" )
        , "SOAPManageNameIDService" : ( $s + "/affwebservices/public/saml2nidsoap" )
    }'
#        , "ACSBindingIndices" : "HTTP-Post:0 HTTP-Artifact:1 PAOS:2"
