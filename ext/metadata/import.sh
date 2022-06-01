#!/bin/bash
#
## import a SAML Metadata File into a Remote IdP Entity,
## a Remote SP Entity or both
## The SHORTNAME is used to formulate other names when necessary
## Those names include
## Certificate Alias names,
## Remote IdP Entity name if not explicitly specified,
## Remote SP Entity name if not explicitly specified
#
SHORTNAME=$1
XML=$2
RIDPNAME=$3
RSPNAME=$4
JSON="$FNAME.json"
FNAME=$SHORTNAME
xq '.' "$XML" > "$JSON"
#
## searchAttr JSONFile BasePath KeyEnding
#
## output the next level keypath ending in $KeyEnding
#
searchAttr() {
    local _json=$1
    local _base=$2
    local _key=$3
    local keys
    local i
    local length

    keys=$(./jq "$_base | keys" "$_json")
    length=$(echo "$keys" | ./jq 'length')
    for (( i = 0; i < $length; ++i )) ; do
        key=$(echo "$keys" | ./jq -r ".[$i]")
#>&2 echo "$i -> $key"
        if [[ "$key" = *$_key ]] ; then
            echo "$key"
#>&2 echo "returning -> $key"
            return
        fi
    done
    }

#
## EntityDescriptor
#
checkEntityDescriptor() {
    local base=""
    local nextkey=$(searchAttr "$JSON" "$base". EntityDescriptor)
    if [ ! -z "$nextkey" ]; then
        echo "$base."'"'"$nextkey"'"'
    fi
    }
#
## Tag: TOP
#
TOP=$(checkEntityDescriptor)
if [ -z "$TOP" ] ; then
    >&2 echo EntityDescriptor check failed, exiting ...
    exit 1
fi
#
## IDPSSODescriptor
#
checkIDP() {
    local _base=$1
    local nextkey=$(searchAttr "$JSON" "$_base" IDPSSODescriptor)
#>&2 echo "receiving $nextkey"
    if [ ! -z "$nextkey" ]; then
        echo "$_base."'"'"$nextkey"'"'
    fi
    }
#
## Tag: IDP
#
IDP=$(checkIDP "$TOP")
if [ -z "$IDP" ] ; then
    >&2 echo IDPSSODescriptor check skipped
fi
#
## SPSSODescriptor
#
checkSP() {
    local _base=$1
    local nextkey=$(searchAttr "$JSON" "$_base" SPSSODescriptor)
# >&2 echo "receiving $nextkey"
    if [ ! -z "$nextkey" ]; then
        echo "$_base."'"'"$nextkey"'"'
    fi
    }
#
## Tag: SP
#
SP=$(checkSP "$TOP")
if [ -z "$SP" ] ; then
    >&2 echo SPSSODescriptor check skipped
fi
#
## KeyDescriptor
#
checkKEY() {
    local _base=$1
    local nextkey=$(searchAttr "$JSON" "$_base" KeyDescriptor)
# >&2 echo "receiving $nextkey"
    if [ ! -z "$nextkey" ]; then
        echo "$_base."'"'"$nextkey"'"'
    fi
    }
if [ ! -z "$IDP" ] ; then
#    >&2 echo "Checking IDP Certs"
    IDPKEY=$(checkKEY "$IDP")
fi
if [ ! -z "$SP" ] ; then
#    >&2 echo "Checking SP Certs"
    SPKEY=$(checkKEY "$SP")
fi
if [ ! -z "$IDPKEY" ] ; then
#    >&2 echo "Checking IDP Certs Type"
    IDPCERT=$(./jq "$IDPKEY" "$JSON")
#    echo "$IDPCERT" | ./jq 'type'
fi
if [ ! -z "$SPKEY" ] ; then
#    >&2 echo "Checking SP Certs Type"
    SPCERT=$(./jq "$SPKEY" "$JSON")
#    echo "$SPCERT" | ./jq 'type'
fi
#
## checkCERT1
#
checkCERT1() {
    local _cert=$1
    local _fname=$2
#    >&2 echo receiving "$_cert"
    use=$(echo "$_cert" | ./jq -r '."@use"')
    local json=$$.json
    echo "$_cert" > "$json"
    local nextkey=.\"$(searchAttr "$json" . KeyInfo)\"
    nextkey=$nextkey.\"$(searchAttr "$json" "$nextkey" X509Data)\"
    nextkey=$nextkey.\"$(searchAttr "$json" "$nextkey" X509Certificate)\"
    cert=$(echo "$_cert" | ./jq -r "$nextkey")
    if [[ "$use" == "signing" ]] ; then
        alias="$_fname"Sign
    fi
    if [[ "$use" == "encryption" ]] ; then
        alias="$_fname"Enc
    fi
    fname="$alias.pem"
    echo "-----BEGIN CERTIFICATE-----" > "$fname"
    echo "$cert" >> "$fname"
    echo "-----END CERTIFICATE-----" >> "$fname"
    alias=$(bash FedCertificates/ext/imppemorsearch.sh "$alias" "$fname")
#    >&2 echo searching cert through "$fname"
#    if oldalias=$(bash FedCertificates/ext/search.sh "$fname") ; then
#        >&2 echo Certificate $_fname for $use exists as $oldalias, skipped
#        alias="$oldalias"
#    else
#        if exist=$(bash FedCertificates/exist.sh "$alias") ; then
#            >&2 echo -n Alias $alias already exists,
#            alias=$alias$(date +"%Y%m%d%N")
#            >&2 echo $_fname for $use to use alias $alias
#        fi
#        exist=$(bash FedCertificates/imppem.sh "$alias" "$fname")
#    fi
    echo "{ \"$use\": \"$alias\" }"
    }
#
## checkCERTS
#
checkCERTS() {
    local _certs=$1
    local _fname=$2
    type=$(echo "$_certs" | ./jq -r 'type')
    if [ ! "$type" == "array" ] ; then
        checkCERT1 "$_certs" "$_fname"
    else
        length=$(echo "$_certs" | ./jq 'length')
        CERTS="{}"
        for (( i = 0; i < $length ; ++i )); do
            CERTS=$(echo "$CERTS" | ./jq \
                ' . + '"$(checkCERT1 "$(echo "$_certs" | ./jq ".[$i]")" "$_fname")")
        done
        echo "$CERTS"
    fi
    }
if [ ! -z "$IDPCERT" ] ; then
    >&2 echo "Checking IDP Certs"
    IDPFEDCERTS=$(checkCERTS "$IDPCERT" "$FNAME")
fi
if [ ! -z "$SPCERT" ] ; then
    >&2 echo "Checking SP Certs"
    SPFEDCERTS=$(checkCERTS "$SPCERT" "$FNAME")
fi
#
##
#
addDescription() {
    local _payload=$1
    local _data=$2
#"Description": "ss imported via metadata"
    _data="imported via metadata $_data"
    echo "$_payload" | ./jq --arg s "$_data" ' . + { "Description": $s }'
    }

#
##
#
outputAttr() {
    local _json=$1
    local _base=$2
    local _key=$3
    local _add=$4
    local token
    local nextkey
    local data
    token=$(searchAttr "$_json" "$_base" "$_key")
    if [ ! -z "$token" ] ; then
        nextkey=$_base.\"$token\"
        ./jq "$nextkey" "$_json"
    fi
    }
#
##
#
addONE() {
    local _payload=$1
    local _key=$2
    local _data=$3
    echo "$_payload" | ./jq --arg s "$_data" ' . + { "'"$_key"'": $s }'
    }
addONEdata() {
    local _payload=$1
    local _key=$2
    local _data=$3
    echo "$_payload" | ./jq --argjson s "$_data" ' . + { "'"$_key"'": $s }'
    }

EID=$(./jq -r "$TOP.\"@entityID\"" "$JSON")

pSSO1() {
    local _data=$1
    local payload=$(./jq -n '. + {"type": "FedEndpoint"}')
    payload=$(echo "$payload" | ./jq '. + {"IsDefault": false}')
    payload=$(echo "$payload" | ./jq '. + {"Index": 0}')
#"@index": "0",
#  "@isDefault"
    s=$(echo "$_data"| ./jq -r '."@index"')
    if [ ! "$s" = "null" ] ; then
        payload=$(echo "$payload" | ./jq --argjson s "$s" '. + {"Index": $s}')
    fi
    s=$(echo "$_data"| ./jq -r '."@isDefault"')
    if [ ! "$s" = "null" ] ; then
        payload=$(echo "$payload" | ./jq --argjson s "$s" '. + {"IsDefault": $s}')
    fi
    s=$(echo "$_data"| ./jq -r '."@Location"')
    payload=$(echo "$payload" | ./jq --arg s "$s" '. + {"LocationURL": $s}')
    s=$(echo "$_data"| ./jq -r '."@Binding"')
    echo "$payload" | ./jq --arg s "$s" '. + {"Binding": $s}'
    }

pSSO() {
    local _data=$1
    local payload=$(./jq -n '[]')
    type=$(echo "$_data" | ./jq -r 'type')
    if [ "$type" != "array" ] ; then
        return
    fi
    length=$(echo "$_data" | ./jq 'length')
    for (( i = 0; i < $length; ++i )) ; do
        one=$(pSSO1 "$(echo "$_data" | ./jq ".[$i]")")
        payload=$(echo "$payload" | ./jq --argjson s "$one" '. + [ $s ] ')
    done
    echo "$payload"
    }

pATTR1() {
    local _data=$1
    local payload=$(./jq -n '. + {"type": "FedSAML2Attribute"}')
    payload=$(echo "$payload" | ./jq '. + {"EncryptFlag": false}')
    payload=$(echo "$payload" | ./jq '. + {"RetrievalMethod": "SSO"}')
    s=$(echo "$_data"| ./jq -r '."@Name"')
    payload=$(echo "$payload" | ./jq --arg s "$s" '. + {"Name": $s}')
    s=$(echo "$_data"| ./jq -r '."@NameFormat"')
    echo "$payload" | ./jq --arg s "$s" '. + {"NameFormat": $s}'
    }

pATTR() {
    local _data=$1
    local payload=$(./jq -n '[]')
    type=$(echo "$_data" | ./jq -r 'type')
    if [ "$type" != "array" ] ; then
        return
    fi
    length=$(echo "$_data" | ./jq 'length')
    for (( i = 0; i < $length; ++i )) ; do
        one=$(pATTR1 "$(echo "$_data" | ./jq ".[$i]")")
        payload=$(echo "$payload" | ./jq --argjson s "$one" '. + [ $s ] ')
    done
    echo "$payload"
    }

if [ ! -z "$IDP" ] ; then
    IDPPAYLOAD="$(./jq -n '. + {"type": "FedIdPRemote"}')"
    IDPPAYLOAD="$(addDescription "$IDPPAYLOAD" "$XML")"
    IDPPAYLOAD="$(addONE "$IDPPAYLOAD" IdPID "$EID")"
    WANTSIGN=$(./jq -r "$IDP.\"@WantAuthnRequestsSigned\"" "$JSON")
    IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" RequireSignedAuthnRequests "$WANTSIGN")"
### NameIDFormat
    NIF="$(outputAttr "$JSON" "$IDP" NameIDFormat)"
    if [ "$(echo "$NIF" | ./jq -r 'type')" == "string" ] ; then
        NIF="[ $NIF ]"
    fi
    IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" NameIDFormat "$NIF")"

### SSO
    >&2 echo SSO
    SSO="$(outputAttr "$JSON" "$IDP" SingleSignOnService)"
    if [ ! -z "$SSO" ] ; then
        if [ "$(echo "$SSO" | ./jq -r 'type')" == "object" ] ; then
            SSO="[ $SSO ]"
        fi
        IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" RemoteSSOServices \
            "$(pSSO "$SSO")")"
#        pSSO "$SSO"
    fi

### SLO
    >&2 echo SLO
    SLO=$(outputAttr "$JSON" "$IDP" SingleLogoutService)
    if [ ! -z "$SLO" ] ; then
        if [ "$(echo "$SLO" | ./jq -r 'type')" == "object" ] ; then
            SLO="[ $SLO ]"
        fi
        IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" RemoteSLOServices \
            "$(pSSO "$SLO")")"
#       echo "$SLO" | ./jq '.'
    fi

### ARS
    >&2 echo ARS
    ARS="$(outputAttr "$JSON" "$IDP" ArtifactResolutionService)"
    if [ ! -z "$ARS" ] ; then
        if [ "$(echo "$ARS" | ./jq -r 'type')" == "object" ] ; then
            ARS="[ $ARS ]"
        fi
        IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" RemoteSOAPArtifactResolutionServices \
            "$(pSSO "$ARS")")"
    fi

### Attribute
    >&2 echo ATTR
    ATTR="$(outputAttr "$JSON" "$IDP" Attribute)"
    if [ ! -z "$ATTR" ] ; then
        if [ "$(echo "$ATTR" | ./jq -r 'type')" == "object" ] ; then
            ATTR="[ $ATTR ]"
        fi
        IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" SupportedAssertionAttributes \
            "$(pATTR "$ATTR")")"
    fi

### VerificationCertLink
    >&2 echo CERTS
    if [ ! -z "$IDPFEDCERTS" ] ; then
        IDPPAYLOAD="$(addONEdata "$IDPPAYLOAD" VerificationCertLink \
            "$(echo "$IDPFEDCERTS" | ./jq '{"path": ("/FedCertificates/" + .signing)}')")"
    fi

### Name and Create
    >&2 echo Name and Create
    if [ -z "$RIDPNAME" ] ; then
        RIDPNAME="R$FNAME.$$"
    fi
    JSON=$$.json
    echo "$IDPPAYLOAD" | ./jq --arg s "$RIDPNAME" '. + { "Name": $s }' > "$JSON"
    bash FedIdPRemotes/create.sh "$JSON"
fi
if [ ! -z "$SP" ] ; then
    SPPAYLOAD="$(./jq -n '. + {"type": "FedSPRemote"}')"
    SPPAYLOAD="$(addDescription "$SPPAYLOAD" "$XML")"
    SPPAYLOAD="$(addONE "$SPPAYLOAD" SPID "$EID")"
### @AuthnRequestsSigned
    SIGNAR=$(./jq -r "$SP.\"@AuthnRequestsSigned\"" "$JSON")
    SPPAYLOAD="$(addONEdata "$SPPAYLOAD" SignAuthnRequests "$SIGNAR")"

### NameIDFormat
    NIF="$(outputAttr "$JSON" "$SP" NameIDFormat)"
    if [ "$(echo "$NIF" | ./jq -r 'type')" == "string" ] ; then
        NIF="[ $NIF ]"
    fi
    SPPAYLOAD="$(addONEdata "$SPPAYLOAD" NameIDFormat "$NIF")"

### SLO
    >&2 echo SLO
    SLO=$(outputAttr "$JSON" "$SP" SingleLogoutService)
    if [ ! -z "$SLO" ] ; then
        if [ "$(echo "$SLO" | ./jq -r 'type')" == "object" ] ; then
            SLO="[ $SLO ]"
        fi
        SPPAYLOAD="$(addONEdata "$SPPAYLOAD" SLOServices \
            "$(pSSO "$SLO")")"
#       echo "$SLO" | ./jq '.'
    fi
### RemoteAssertionConsumerServices
    >&2 echo ACS
    ACS="$(outputAttr "$JSON" "$SP" AssertionConsumerService)"
    if [ ! -z "$ACS" ] ; then
        if [ "$(echo "$ACS" | ./jq -r 'type')" == "object" ] ; then
            ACS="[ $ACS ]"
        fi
        SPPAYLOAD="$(addONEdata "$SPPAYLOAD" RemoteAssertionConsumerServices \
            "$(pSSO "$ACS")")"
    fi

    >&2 echo CERTS
    if [ ! -z "$SPFEDCERTS" ] ; then
### VerificationCertificate
        ONECERT="$(echo "$SPFEDCERTS" | ./jq -r '.signing')"
        if [ ! -z "$ONECERT" ] ; then
            if [[ ! "$ONECERT" == "null" ]] ; then
            SPPAYLOAD="$(addONEdata "$SPPAYLOAD" VerificationCertificate \
                "$(./jq -n --arg s "$ONECERT" '{"path": ("/FedCertificates/" + $s)}')")"
            fi
        fi
### EncryptionCertificate
        ONECERT="$(echo "$SPFEDCERTS" | ./jq -r '.encryption')"
        if [ ! -z "$ONECERT" ] ; then
            if [[ ! "$ONECERT" == "null" ]] ; then
            SPPAYLOAD="$(addONEdata "$SPPAYLOAD" EncryptionCertificate \
                "$(./jq -n --arg s "$ONECERT" '{"path": ("/FedCertificates/" + $s)}')")"
            fi
        fi
    fi

### Name and Create
    >&2 echo Name and Create
    if [ -z "$RSPNAME" ] ; then
        RSPNAME="R$FNAME.$$"
    fi
    JSON=$$.json
    echo "$SPPAYLOAD" | ./jq --arg s "$RSPNAME" '. + { "Name": $s }' > "$JSON"
    bash FedSPRemotes/create.sh "$JSON"
fi
