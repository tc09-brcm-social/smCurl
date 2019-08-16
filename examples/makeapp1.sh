#!/bin/bash
# assumes iis-01, apache-01 and CA+Directory existed
mypwd=$(pwd)
cd ..
##
### Authe Scheme
##
SMAUTH=${NS}demoauth1
SMAUTHTEMP=SmAuthSchemes/temp/formauth.temp
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" > "$JSON"
bash SmAuthSchemes/create.sh "$JSON"
bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
##
### Domain
##
SMDOMAIN=${NS}Demo1
SMDIR=${NS}CA+Directory
SMDOMAINTEMP=SmDomains/temp/domain0.temp
JSON=$$.json
bash "$SMDOMAINTEMP" "$SMDOMAIN" "$SMDIR" >"$JSON"
bash SmDomains/create.sh "$JSON"
bash SmDomains/read.sh "$SMDOMAIN" | ./jq '.data'
##
### AgentGroup and members
##
SMAGENTGROUP=wsGroup1
JSON=$$.json
bash SmAgentGroups/temp/ag.temp "$SMAGENTGROUP" > "$JSON"
bash SmAgentGroups/create.sh "$JSON"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
SMAGENT=iis-01
bash SmAgents/read.sh "$SMAGENT" | ./jq '.data'
bash SmAgentGroups/addagent.sh "$SMAGENTGROUP" "$SMAGENT"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
SMAGENT=apache-01
bash SmAgents/read.sh "$SMAGENT" | ./jq '.data'
bash SmAgentGroups/addagent.sh "$SMAGENTGROUP" "$SMAGENT"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
##
### Realm
##
APPVDIR=/Demoapp1
SMREALM=Demoapp1Realm
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
SMPOLICY=All
JSON=$$.json
bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
bash SmPolicies/create.sh "$SMDOMAIN" "$JSON"
bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
