#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
IMPNAME=Ridp${IDP}
if ! EXIST=$(bash FedIdPPartnerships/exist.sh "${SPNAME}-${IDPNAME}"); then
    >&2 echo "${SPNAME}-${IDPNAME} does not exist, skipped ..."
else
    >&2 echo "${SPNAME}-${IDPNAME} exists, removing ..."
    bash FedIdPPartnerships/deactivate.sh "${SPNAME}-${IDPNAME}" | ./jq '.data'
    bash FedIdPPartnerships/delete.sh "${SPNAME}-${IDPNAME}"
fi
if ! EXIST=$(bash FedIdPRemotes/exist.sh "$IDPNAME"); then
    >&2 echo "IDP Remote $IDPNAME exist not exist, skipped ..."
else
    >&2 echo "IDP Remote $IDPNAME exists, removing ..."
    bash FedIdPRemotes/delete.sh "$IDPNAME"
fi
if ! EXIST=$(bash FedIdPRemotes/exist.sh "$IMPNAME"); then
    >&2 echo "IdP Remote $IMPNAME does not exist, skipped ..."
else
    >&2 echo "IdP Remote $IMPNAME exists, removing ..."
    bash FedIdPRemotes/delete.sh "$IMPNAME"
fi
