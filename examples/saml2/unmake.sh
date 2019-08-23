#!/bin/bash
MYPWD=$(pwd)
cd ../..
INSTANCE=idpn1
LIDPNAME=Ldemo${INSTANCE}
RIDPNAME=Rdemo${INSTANCE}
IDP=${INSTANCE}
INSTANCE=spn1
LSPNAME=Ldemo${INSTANCE}
RSPNAME=Rdemo${INSTANCE}
SP=${INSTANCE}
SPIDP=saml2${SP}${IDP}
IDPSP=saml2${IDP}${SP}
bash FedIdPPartnerships/delete.sh "$SPIDP"
bash FedSPPartnerships/delete.sh "$IDPSP"
bash FedIdPLocals/delete.sh "$LIDPNAME"
bash FedSPLocals/delete.sh "$LSPNAME"
bash FedIdPRemotes/delete.sh "$RIDPNAME"
bash FedSPRemotes/delete.sh "$RSPNAME"
