#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
#
# CA Directory: a required user directory
#
SMDIR="CA Directory"
ESCNAME=$(bash utils/escName.sh "$SMDIR")
UD=${ESCNAME}
if ! EXIST=$(bash SmUserDirectories/exist.sh "$UD"); then
    STATUS=$?
    >&2 echo "required User Directory does not exist. Exiting"
    exit "${STATUS}"
fi
echo "$EXIST" | ./jq '.data'
##
### FedCertificates idpdemo
##
SMCERT=idpdemo
if ! EXIST=$(bash FedCertificates/exist.sh "$SMCERT"); then
    SMCERTTEMP=${MYPWD}/idpdemocert.temp
    SMCERTPWD=password
    JSON=$$.json
    bash "$SMCERTTEMP" "$SMCERT" "$SMCERTPWD" > "$JSON"
    EXIST=$(bash FedCertificates/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
IDPCERT=${SMCERT}
##
### FedCertificates spdemo
##
SMCERT=spdemo
if ! EXIST=$(bash FedCertificates/exist.sh "$SMCERT"); then
    SMCERTTEMP=${MYPWD}/spdemocert.temp
    SMCERTPWD=password
    JSON=$$.json
    bash "$SMCERTTEMP" "$SMCERT" "$SMCERTPWD" > "$JSON"
    EXIST=$(bash FedCertificates/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
SPCERT=${SMCERT}
##
### FedIdPLocals Ldemo${IDPINSTANCE}
##
INSTANCE=${IDPINST}
LIDPTEMP=${MYPWD}/Lidp.temp
LIDPNAME=Ldemo${INSTANCE}
IDPID=https://idp.demo/${INSTANCE}
if ! EXIST=$(bash FedIdPLocals/exist.sh "${LIDPNAME}"); then
    JSON=$$.json
    bash "$LIDPTEMP" "$INSTANCE" "$IDPCERT" > "$JSON"
    EXIST=$(bash FedIdPLocals/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
##
### FedSPLocals Ldemo${SPINSTANCE}
##
INSTANCE=${SPINST}
LSPTEMP=${MYPWD}/Lsp.temp
LSPNAME=Ldemo${INSTANCE}
SPID=https://sp.demo/${INSTANCE}
if ! EXIST=$(bash FedSPLocals/exist.sh "${LSPNAME}"); then
    JSON=$$.json
    bash "$LSPTEMP" "$INSTANCE" "$SPCERT" > "$JSON"
    EXIST=$(bash FedSPLocals/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
##
### FedIdPRemotes Rdemo#{IDPINSTANCE}
##
INSTANCE=${IDPINST}
IDP=${INSTANCE}
RIDPTEMP=${MYPWD}/Ridp.temp
RIDPNAME=Rdemo${INSTANCE}
IDPID=https://idp.demo/${INSTANCE}
if ! EXIST=$(bash FedIdPRemotes/exist.sh "${RIDPNAME}"); then
    JSON=$$.json
    bash "$RIDPTEMP" "$INSTANCE" "$IDPCERT" > "$JSON"
    EXIST=$(bash FedIdPRemotes/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
##
### FedSPRemotes Ldemo${SPINSTANCE}
##
INSTANCE=${SPINST}
SP=${INSTANCE}
RSPTEMP=${MYPWD}/Rsp.temp
RSPNAME=Rdemo${INSTANCE}
SPID=https://sp.demo/${INSTANCE}
if ! EXIST=$(bash FedSPRemotes/exist.sh "${RSPNAME}"); then
    JSON=$$.json
    bash "$RSPTEMP" "$INSTANCE" "$SPCERT" > "$JSON"
    EXIST=$(bash FedSPRemotes/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
if [ -z ${SPIDP+x} ]; then
    SPIDP=saml2${SP}${IDP}
fi
if ! EXIST=$(bash FedIdPPartnerships/exist.sh "$SPIDP"); then
    JSON=$$.json
    bash "${MYPWD}/spidp.temp" "$SPIDP" "$SP" "$IDP" "$SPCERT" "$IDPCERT" "$UD" > "$JSON"
    EXIST=$(bash FedIdPPartnerships/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
if [ -z ${IDPSP+x} ]; then
    IDPSP=saml2${IDP}${SP}
fi
if ! EXIST=$(bash FedSPPartnerships/exist.sh "$IDPSP"); then
    JSON=$$.json
    bash "${MYPWD}/idpsp.temp" "$IDPSP" "$IDP" "$SP" "$IDPCERT" "$SPCERT" "$UD" > "$JSON"
    EXIST=$(bash FedSPPartnerships/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
