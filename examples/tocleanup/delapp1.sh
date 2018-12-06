APPVDIR=app1
SMDIR=DemoUser1
SMAGENT=apache-01
SMAUTH=BasicForm
SMDOMAIN=Domain$APPVDIR
SMREALM=REALM$APPVDIR
SMRULE=AllowGetPost
SMPOLICY=AllUsers
bash delPolicy.sh "$SMDOMAIN" "$SMPOLICY"
bash delRule.sh "$SMDOMAIN" "$SMREALM" "$SMRULE"
bash delRealm.sh "$SMDOMAIN" "$SMREALM"
bash delDomain.sh "$SMDOMAIN"
bash delDir.sh "$SMDIR"
