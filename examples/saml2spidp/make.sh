#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
IMPNAME=Ridp${IDP}
if [ ! -f "${MYPWD}/${IDPXML}" ]; then
    >&2 echo "Metadata file $IDPXML does not exist, exiting ..."
    exit 1
fi
if ! EXIST=$(bash FedSPLocals/exist.sh "$SPNAME"); then
    >&2 echo "SP Local $SPNAME does not exist, exiting ..."
    exit 1
fi
if EXIST=$(bash FedIdPRemotes/exist.sh "$IDPNAME"); then
    >&2 echo "IdP Remote $IDPNAME already exists, skip importing the metadata ..."
else
    if EXIST=$(bash FedIdPRemotes/exist.sh "$IMPNAME"); then
        >&2 echo "IdP Remote $IMPNAME already exists, skip importing the metadata ..."
    else
        bash FedIdPRemotes/ext/importmetadata.sh "${MYPWD}/$IDPXML" "$IDP" "$IDP" | ./jq '.'
        if ! EXIST=$(bash FedIdPRemotes/exist.sh "$IMPNAME"); then
            >&2 echo "Metadata file $IMPNAME import failed, exiting ..."
            exit 1
        fi
        bash FedIdPRemotes/ext/rename.sh "$IMPNAME" "$IDPNAME" | ./jq '.data'
        if ! EXIST=$(bash FedIdPRemotes/exist.sh "$IDPNAME"); then
            >&2 echo "IdPRemote rename from $IMPNAME to $IDPNAME failed, exiting ..."
            exit 1
        fi
    fi
fi
echo "$EXIST" | ./jq '.data'
#
# CA Directory: a required user directory
#
SMDIR=${UD}
ESCNAME=$(bash utils/escName.sh "$SMDIR")
UD=${ESCNAME}
if ! EXIST=$(bash SmUserDirectories/exist.sh "$UD"); then
    STATUS=$?
    >&2 echo "required User Directory does not exist. Exiting"
    exit "${STATUS}"
fi
echo "$EXIST" | ./jq '.data'
if ! EXIST=$(bash FedIdPPartnerships/exist.sh "${SPNAME}-${IDPNAME}"); then
    JSON=$$.json
    bash "${MYPWD}/spidp.temp" "$SPNAME" "$IDPNAME" "$UD" "$LANDING" > "$JSON"
    EXIST=$(bash FedIdPPartnerships/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
