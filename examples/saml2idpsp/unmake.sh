#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
IMPNAME=Rsp${SP}
if ! EXIST=$(bash FedSPPartnerships/exist.sh "${IDPNAME}-${SPNAME}"); then
    >&2 echo "${IDPNAME}-${SPNAME} does not exist, skipped ..."
else
    >&2 echo "${IDPNAME}-${SPNAME} exists, removing ..."
    bash FedSPPartnerships/deactivate.sh "${IDPNAME}-${SPNAME}" | ./jq '.data'
    bash FedSPPartnerships/delete.sh "${IDPNAME}-${SPNAME}"
fi
if ! EXIST=$(bash FedSPRemotes/exist.sh "$SPNAME"); then
    >&2 echo "SP Remote $SPNAME exist not exist, skipped ..."
else
    >&2 echo "SP Remote $SPNAME exists, removing ..."
    bash FedSPRemotes/delete.sh "$SPNAME"
fi
if ! EXIST=$(bash FedSPRemotes/exist.sh "$IMPNAME"); then
    >&2 echo "SP Remote $IMPNAME does not exist, skipped ..."
else
    >&2 echo "SP Remote $IMPNAME exists, removing ..."
    bash FedSPRemotes/delete.sh "$IMPNAME"
fi
