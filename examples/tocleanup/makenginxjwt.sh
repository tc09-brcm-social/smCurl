#!/bin/bash
# BasicForm Auth
# Demo Domain
# sps Agent - could be secureproxy-01 too
# CA Directory - user directory
SMDOMAIN=Demo
SMDIR="CA Directory"
SMAPPVDIR=/affwebservices/redirectjsp/openid
SMAGENT=sps
SMAUTH=BasicForm
SMREALM=openidap
SMRULE=AllowGetPost
bash crRealm0.sh "$SMREALM" "$SMAPPVDIR" "$SMAGENT" "$SMAUTH" "$SMDOMAIN"
bash crRule.sh "$SMDOMAIN" "$SMREALM"
bash crPolicy.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR"
