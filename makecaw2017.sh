#!/bin/bash
SMDIR="CA Directory"
SMLDAPHOST=dir.sso
SMLDAPPORT=10589
echo bash crDir.sh "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT"
SMAGENT=apache-01
echo bash crAgent.sh "${SMAGENT}"
SMAUTH=BasicForm
SMAUTHTEMP=formauth.temp
echo bash crAuth.sh "${SMAUTH}" "${SMAUTHTEMP}"
SMDOMAIN=Demo
echo bash crDomain0.sh "$SMDOMAIN" "$SMDIR"
SMADMIN=bjones
SMADMINPWD=CAdemo123
echo bash crLegAdmin.sh "$SMADMIN" "$SMADMINPWD"
