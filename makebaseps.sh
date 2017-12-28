#!/bin/bash
. ./authn
SMHCO=InitialHCO
SMPSHOST=${RESTHOST}
bash crHCO.sh "${SMHCO}" "${SMPSHOST}"
SMDIR="CA Directory"
SMLDAPHOST=${RESTHOST}
SMLDAPPORT=20589
bash crDir.sh "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT"
SMAUTH=BasicForm
SMAUTHTEMP=formauth.temp
bash crAuth.sh "${SMAUTH}" "${SMAUTHTEMP}"
SMAGENT=secureproxy-01
bash crAgent.sh "${SMAGENT}"
SMACO=SecureProxyServer
SMACOTEMP=acoSPS.temp
bash crACO.sh "${SMACO}" "${SMACOTEMP}" "${SMAGENT}"
SMAGENT=apache-01
bash crAgent.sh "${SMAGENT}"
SMACO=Apache
SMACOTEMP=acoApache.temp
bash crACO.sh "${SMACO}" "${SMACOTEMP}" "${SMAGENT}"
SMDOMAIN=Demo
bash crDomain0.sh "$SMDOMAIN" "$SMDIR"
