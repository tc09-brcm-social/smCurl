* realmAG0.temp
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
