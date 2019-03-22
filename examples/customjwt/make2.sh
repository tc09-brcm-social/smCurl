#!/bin/bash
#
# some of the templates assumes the certificate alias ssl exists
# 
MYPWD=`pwd`
. ${MYPWD}/env.shlib
cd ../..
##
### Domain
##
SMDOMAIN=${NS}DemoCustomJWT
SMDIR=${NS}CA+Directory
SMDOMAINTEMP=SmDomains/temp/domain0.temp
JSON=$$.json
bash "$SMDOMAINTEMP" "$SMDOMAIN" "$SMDIR" >"$JSON"
#bash SmDomains/create.sh "$JSON"
bash SmDomains/read.sh "$SMDOMAIN" | ./jq '.data'
##
### AgentGroup and members
##
SMAGENTGROUP=CustumJWTGroup
JSON=$$.json
bash SmAgentGroups/temp/ag.temp "$SMAGENTGROUP" > "$JSON"
#bash SmAgentGroups/create.sh "$JSON"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
SMAGENT=${MYAGENT}
bash SmAgents/read.sh "$SMAGENT" | ./jq '.data'
#bash SmAgentGroups/addAgent2Group.sh "$SMAGENTGROUP" "$SMAGENT"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'

makeUC() {
   ##
   ####NOW EACH Auth Scheme and Policy
   UC=$1
   ##
   ### Authe Scheme subhs384
   ##
   SMAUTH=${UC}
   SMAUTHTEMP=${MYPWD}/${UC}.temp
   JSON=$$.json
   bash "$SMAUTHTEMP" "$SMAUTH" "${AUTHSERVER}" > "$JSON"
   bash SmAuthSchemes/create.sh "$JSON"
   bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
   ##
   ### Realm subhs384
   ##
   APPVDIR=${VDIRHOME}/${UC}
   SMREALM=${UC}
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
   SMPOLICY=${UC}All
   JSON=$$.json
   bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
   bash SmPolicies/create.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" "$JSON"
   bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
   ##
   ### Deploy Sample Pages
   ##
   mkdir -p "${RESOURCEHOME}/jwt"
   cp -pR "${MYPWD}/headers" "${RESOURCEHOME}/jwt/${UC}"
   }

#makeUC "subhs384"
#makeUC "subrs384"
#makeUC "subhs512"
#makeUC "subrs512"
#makeUC "useridhs384"
#makeUC "useridrs384"
#makeUC "useridhs512"
#makeUC "useridrs512"
#makeUC "subes256"
#makeUC "subes384"
#makeUC "subes512"
#makeUC "userides256"
#makeUC "userides384"
#makeUC "userides512"

