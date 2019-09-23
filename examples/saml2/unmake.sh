#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib
cd ../..
INSTANCE=${IDPINST}
LIDPNAME=Ldemo${INSTANCE}
RIDPNAME=Rdemo${INSTANCE}
IDP=${INSTANCE}
INSTANCE=${SPINST}
LSPNAME=Ldemo${INSTANCE}
RSPNAME=Rdemo${INSTANCE}
SP=${INSTANCE}
SPIDP=saml2${SP}${IDP}
IDPSP=saml2${IDP}${SP}
bash FedIdPPartnerships/deactivate.sh "$SPIDP"
bash FedIdPPartnerships/delete.sh "$SPIDP"
bash FedSPPartnerships/deactivate.sh "$IDPSP"
bash FedSPPartnerships/delete.sh "$IDPSP"
bash FedIdPLocals/delete.sh "$LIDPNAME"
bash FedSPLocals/delete.sh "$LSPNAME"
bash FedIdPRemotes/delete.sh "$RIDPNAME"
bash FedSPRemotes/delete.sh "$RSPNAME"
