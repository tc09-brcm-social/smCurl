# assumes iis-01 and CA+Directory existed
mypwd=`pwd`
. ../../env.shlib
cd ../../$cassoHome
DIRNAME=$(cd "${BASH_SOURCE[0]%/*}"; pwd)
. "${DIRNAME}/../authn"
##
### Authe Scheme
##
SMAUTH=${NS}jwtauth
SMAUTHTEMP=${mypwd}/formauth.temp
JSON=$$.json
bash "$SMAUTHTEMP" "$SMAUTH" > "$JSON"
#bash SmAuthSchemes/create.sh "$JSON"
bash SmAuthSchemes/read.sh "$SMAUTH" | ./jq '.data'
##
### Domain
##
SMDOMAIN=${NS}Demo
SMDIR=${NS}CA+Directory
SMDOMAINTEMP=SmDomains/temp/domain0.temp
JSON=$$.json
bash "$SMDOMAINTEMP" "$SMDOMAIN" "$SMDIR" >"$JSON"
#bash SmDomains/create.sh "$JSON"
bash SmDomains/read.sh "$SMDOMAIN" | ./jq '.data'
##
### AgentGroup and members
##
SMAGENTGROUP=wsGroup
JSON=$$.json
bash SmAgentGroups/temp/ag.temp "$SMAGENTGROUP" > "$JSON"
#bash SmAgentGroups/create.sh "$JSON"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
SMAGENT=iis-01
bash SmAgents/read.sh "$SMAGENT" | ./jq '.data'
#bash SmAgentGroups/addAgent2Group.sh "$SMAGENTGROUP" "$SMAGENT"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
SMAGENT=apache-01
bash SmAgents/read.sh "$SMAGENT" | ./jq '.data'
#bash SmAgentGroups/addAgent2Group.sh "$SMAGENTGROUP" "$SMAGENT"
bash SmAgentGroups/read.sh "$SMAGENTGROUP" | ./jq '.data'
##
### Realm
##
APPVDIR=/Authentication/uc4/protected05
SMREALM=Authnuc4p5protected
JSON=$$.json
bash "SmRealms/temp/realmAG0.temp" "$SMREALM" "$APPVDIR" "$SMAGENTGROUP" "$SMAUTH" > "$JSON"
#bash SmRealms/create.sh "$SMDOMAIN" "$JSON"
bash SmRealms/read.sh "$SMDOMAIN" "$SMREALM" | ./jq '.data'
##
### Rule
##
SMRULE=AllowGetPost
#bash SmRules/create.sh "$SMDOMAIN" "$SMREALM" "SmRules/temp/${SMRULE}.json"
bash SmRules/read.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" | ./jq '.data'
##
### Policy
##
SMPOLICY=Authnuc4p5AllUser
JSON=$$.json
bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
#bash SmPolicies/create.sh "$SMDOMAIN" "$SMREALM" "$SMRULE" "$JSON"
bash SmPolicies/read.sh "$SMDOMAIN" "$SMPOLICY" | ./jq '.data'
