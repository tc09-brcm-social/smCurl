APPVDIR=app1
SMDIR="CA Directory"
SMLDAPHOST=ip-10-0-1-103
SMLDAPPORT=10589
SMAGENT=apache-01
SMACO=ApacheACO1
SMACOTEMP=acoApache.temp
SMHCO=InitialHCO
SMPSHOST=ip-10-0-1-102
SMCERT=apcert
SMCERTTEMP=apcert.key.temp
SMAUTH=BasicForm
SMAUTHTEMP=formauth.temp
SMDOMAIN=Domain$APPVDIR
SMREALM=REALM$APPVDIR
SMRULE=AllowGetPost
echo bash crAgent.sh "${SMAGENT}"
echo bash crACO.sh "${SMACO}" "${SMACOTEMP}" "${SMAGENT}"
echo bash crHCO.sh "${SMHCO}" "${SMPSHOST}"
echo keyentry has to be imported through AdminUI
echo as the encryption key may be different also impcert does not support
echo bash impCert.sh "${SMCERT}" "${SMCERTTEMP}"
echo bash crAuth.sh "${SMAUTH}" "${SMAUTHTEMP}"
bash crDir.sh "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT"
