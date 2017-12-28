#!/bin/bash
#12.8 JWT demo feature
echo keyentry has to be imported through AdminUI
echo as the encryption key may be different also impcert does not support
##apcert.key.temp is a pre-made key
SMCERT=apcert
SMCERTTEMP=apcert.key.temp
echo bash impCert.sh "${SMCERT}" "${SMCERTTEMP}"
SMAUTH=jwtapcert
SMAUTHTEMP=jwtauth.temp
JSON=$$.json
bash "$SMAUTHTEMP" "${SMAUTH}" "${SMCERT}" > $JSON
bash crAuthJson.sh "$JSON"
## Demo Domain, CA Directory, and secureproxy-01 are in makebaseps.sh
SMDOMAIN=Demo
SMDIR="CA Directory"
SMAPPVDIR=/affwebservices/jwt
SMAGENT=secureproxy-01
SMAUTH=jwtapcert
SMREALM=jwt
SMRULE=AllowGetPost
bash crRealm0.sh "$SMREALM" "$SMAPPVDIR" "$SMAGENT" "$SMAUTH" "$SMDOMAIN"
bash crRule.sh "$SMDOMAIN" "$SMREALM"
bash crPolicy.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR"
SMOP=op1
SMRP=rp1
SMAUTH=pjwt-$SMRP-$SMOP
SMAUTHTEMP=pjwtacf.temp
SMRPAGHOSTPORT=ssoag.casso128.com:7443
##SMCID is dependent on the OP
SMCID=00071285-0a7f-19e8-8b01-01660a000000
SMSCOPE=openid+email
SMOPBASE=https%3A%2F%2Fssoag.caworld2017.com%3A7443%2Faffwebservices%2FCASSO%2Foidc%2F
SMOPAEURL=${SMOPBASE}authorize
SMOPTEURL=${SMOPBASE}token
SMOPC2TURL=https%3A%2F%2Fssoag.caworld2017.com%3A7443%2Faffwebservices%2Fpublic%2Foidc%2Fc2t.html
SMRPJCSURL=https%3A%2F%2Fssoag.casso128.com%3A7443%2Faffwebservices%2Fjwt.html
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" "$SMRPAGHOSTPORT" "$SMCID" "$SMSCOPE" \
	"$SMOPAEURL" "$SMOPTEURL" "$SMOPC2TURL" "$SMRPJCSURL" > $JSON
bash crAuthJson.sh "$JSON"
## domain policy
## Demo Domain, CA Directory, and apache-01 are in makebaseps.sh
SMDOMAIN=Demo
SMDIR="CA Directory"
SMAPPVDIR=/pjwt-rp1-op1
SMAGENT=apache-01
SMREALM=pjwt-rp1-op1
SMRULE=AllowGetPost
SMPOLICY=jwtAllUsers
bash crRealm0.sh "$SMREALM" "$SMAPPVDIR" "$SMAGENT" "$SMAUTH" "$SMDOMAIN"
bash crRule.sh "$SMDOMAIN" "$SMREALM"
bash crPolicy0.sh "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR"
