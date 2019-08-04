#!/bin/bash
#
# some of the templates assumes the certificate alias ssl exists
# 
MYPWD=`pwd`
. ${MYPWD}/env.shlib
cd ../..
##
### Deploy jwtlogin.fcc
##
#cp -p jwtlogin.fcc "${FORMHOME}/jwtlogin.fcc"
##
### Domain
##
SMDOMAIN=${NS}DemoCustomJWT
SMDIR=${NS}CA+Directory
SMDOMAINTEMP=SmDomains/temp/domain0.temp
JSON=$$.json
bash "$SMDOMAINTEMP" "$SMDOMAIN" "$SMDIR" >"$JSON"
bash SmDomains/create.sh "$JSON"
bash SmDomains/read.sh "$SMDOMAIN" | ./jq '.data'
##
### AgentGroup and members
##
SMAGENTGROUP=CustumJWTGroup
JSON=$$.json
bash SmAgentGroups/temp/ag.temp "$SMAGENTGROUP" > "$JSON"
bash SmAgentGroups/create.sh "$JSON"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
SMAGENT=${MYAGENT}
bash SmAgents/read.sh "$SMAGENT" | ./jq '.data'
bash SmAgentGroups/addAgent2Group.sh "$SMAGENTGROUP" "$SMAGENT"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
##
####NOW EACH Auth Scheme and Policy
##
### Authe Scheme subhs256
##
SMAUTH=subhs256
SMAUTHTEMP=${MYPWD}/subhs256.temp
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" "${AUTHSERVER}" > "$JSON"
bash SmAuthSchemes/create.sh "$JSON"
bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
##
### Realm subhs256
##
APPVDIR=/affwebservices/jwt/subhs256
SMREALM=subhs256
JSON=$$.json
bash "SmRealms/temp/realmAG0.temp" "$SMREALM" "$APPVDIR" "$SMAGENTGROUP" "$SMAUTH" > "$JSON"
bash SmRealms/create.sh "$SMDOMAIN" "$JSON"
bash SmRealms/read.sh "$SMDOMAIN" "$SMREALM" | ./jq '.data'
##
### Rule
##
SMRULE=AllowGetPost
bash SmRules/create.sh "$SMDOMAIN" "$SMREALM" "SmRules/temp/${SMRULE}.json"
bash SmRules/read.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" | ./jq '.data'
##
### Policy
##
SMPOLICY=subhs256All
JSON=$$.json
bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
bash SmPolicies/create.sh "$SMDOMAIN" "$JSON"
bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
##
### Authe Scheme useridhs256
##
SMAUTH=useridhs256
SMAUTHTEMP=${MYPWD}/useridhs256.temp
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" "${AUTHSERVER}" > "$JSON"
bash SmAuthSchemes/create.sh "$JSON"
bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
##
### Realm useridhs256
##
APPVDIR=/affwebservices/jwt/useridhs256
SMREALM=useridhs256
JSON=$$.json
bash "SmRealms/temp/realmAG0.temp" "$SMREALM" "$APPVDIR" "$SMAGENTGROUP" "$SMAUTH" > "$JSON"
bash SmRealms/create.sh "$SMDOMAIN" "$JSON"
bash SmRealms/read.sh "$SMDOMAIN" "$SMREALM" | ./jq '.data'
##
### Rule
##
SMRULE=AllowGetPost
bash SmRules/create.sh "$SMDOMAIN" "$SMREALM" "SmRules/temp/${SMRULE}.json"
bash SmRules/read.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" | ./jq '.data'
##
### Policy
##
SMPOLICY=useridhs256All
JSON=$$.json
bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
bash SmPolicies/create.sh "$SMDOMAIN" "$JSON"
bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
##
### Authe Scheme subrs256
##
SMAUTH=subrs256
SMAUTHTEMP=${MYPWD}/subrs256.temp
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" "${AUTHSERVER}" > "$JSON"
bash SmAuthSchemes/create.sh "$JSON"
bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
##
### Realm subrs256
##
APPVDIR=/affwebservices/jwt/subrs256
SMREALM=subrs256
JSON=$$.json
bash "SmRealms/temp/realmAG0.temp" "$SMREALM" "$APPVDIR" "$SMAGENTGROUP" "$SMAUTH" > "$JSON"
bash SmRealms/create.sh "$SMDOMAIN" "$JSON"
bash SmRealms/read.sh "$SMDOMAIN" "$SMREALM" | ./jq '.data'
##
### Rule
##
SMRULE=AllowGetPost
bash SmRules/create.sh "$SMDOMAIN" "$SMREALM" "SmRules/temp/${SMRULE}.json"
bash SmRules/read.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" | ./jq '.data'
##
### Policy
##
SMPOLICY=subrs256All
JSON=$$.json
bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
bash SmPolicies/create.sh "$SMDOMAIN" "$JSON"
bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
##
### Authe Scheme useridrs256
##
SMAUTH=useridrs256
SMAUTHTEMP=${MYPWD}/useridrs256.temp
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" "${AUTHSERVER}" > "$JSON"
bash SmAuthSchemes/create.sh "$JSON"
bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
##
### Realm useridrs256
##
APPVDIR=/affwebservices/jwt/useridrs256
SMREALM=useridrs256
JSON=$$.json
bash "SmRealms/temp/realmAG0.temp" "$SMREALM" "$APPVDIR" "$SMAGENTGROUP" "$SMAUTH" > "$JSON"
bash SmRealms/create.sh "$SMDOMAIN" "$JSON"
bash SmRealms/read.sh "$SMDOMAIN" "$SMREALM" | ./jq '.data'
##
### Rule
##
SMRULE=AllowGetPost
bash SmRules/create.sh "$SMDOMAIN" "$SMREALM" "SmRules/temp/${SMRULE}.json"
bash SmRules/read.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" | ./jq '.data'
##
### Policy
##
SMPOLICY=useridrs256All
JSON=$$.json
bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
bash SmPolicies/create.sh "$SMDOMAIN" "$JSON"
bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
