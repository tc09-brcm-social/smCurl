#!/bin/bash
# assumes apache-01 and BasicForm existed
# assume DemoUser1 created on CA Directory
APPVDIR=app1
SMDIR=DemoUser1
SMLDAPHOST=cheyi02-U176660.ca.com
SMLDAPPORT=30389
SMAGENT=apache-01
SMAUTH=BasicForm
SMDOMAIN=Domain$APPVDIR
SMREALM=REALM$APPVDIR
SMRULE=AllowGetPost
bash crDir.sh "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT"
bash crDomain.sh "$APPVDIR" "$SMDIR"
bash crRealm.sh "$APPVDIR" "$SMAGENT" "$SMAUTH" "$SMDOMAIN"
bash crRule.sh "$SMDOMAIN" "$SMREALM"
bash crPolicy.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR"
