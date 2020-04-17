#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
IMPNAME=Rsp${SP}
if [ ! -f "${MYPWD}/${SPXML}" ]; then
    >&2 echo "Metadata file $SPXML does not exist, exiting ..."
    exit 1
fi
if ! EXIST=$(bash FedIdPLocals/exist.sh "$IDPNAME"); then
    >&2 echo "IdP Local $IDPNAME does not exist, exiting ..."
    exit 1
fi
if EXIST=$(bash FedSPRemotes/exist.sh "$SPNAME"); then
    >&2 echo "SP Remote $SPNAME already exists, skip importing the metadata ..."
else
    if EXIST=$(bash FedSPRemotes/exist.sh "$IMPNAME"); then
        >&2 echo "SP Remote $IMPNAME already exists, skip importing the metadata ..."
    else
        bash FedSPRemotes/ext/importmetadata.sh "${MYPWD}/$SPXML" "$SP" "$SP" | ./jq '.'
        if ! EXIST=$(bash FedSPRemotes/exist.sh "$IMPNAME"); then
            >&2 echo "Metadata file $IMPNAME import failed, exiting ..."
            exit 1
        fi
        bash FedSPRemotes/ext/rename.sh "$IMPNAME" "$SPNAME" | ./jq '.data'
        if ! EXIST=$(bash FedSPRemotes/exist.sh "$SPNAME"); then
            >&2 echo "SPRemote rename from $IMPNAME to $SPNAME failed, exiting ..."
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
if ! EXIST=$(bash FedSPPartnerships/exist.sh "${IDPNAME}-${SPNAME}"); then
    JSON=$$.json
    bash "${MYPWD}/idpsp.temp" "$IDPNAME" "$SPNAME" "$UD" > "$JSON"
    EXIST=$(bash FedSPPartnerships/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
