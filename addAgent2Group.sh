#!/bin/bash
#addAgent2Group give an existing AgentGroup an additional Agent
SMAGENTGROUP=$1
SMAGENT=$2
AGENT=`bash readAgent.sh "$SMAGENT" | ./jq '.responseType'`
if [ "$AGENT" == "\"error\"" ]; then
    echo "$SMAGENT does not exist."
    exit 1
fi
READGROUP=`bash readAgentGroup.sh "$SMAGENTGROUP"`
GROUP=`echo "$READGROUP" | ./jq '.responseType'`
if [ "$GROUP" == "\"error\"" ]; then
    echo "$SMAGENTGROUP does not exist."
    exit 1
fi
for i in `echo "$READGROUP" | ./jq '.data.AgentsLink[].path' | awk '{print substr($0,12, length($0) - 12);}'` ; do
    if [ "$SMAGENT" == "$i" ]; then
	echo "$SMAGENT has been in $SMAGENTGROUP"
	exit 0
    fi
done
echo "adding $SMAGENT into $SMAGENTGROUP"
JSON=$$.json
echo "$READGROUP" | ./jq ".data | .AgentsLink += [ { path: \"/SmAgents/$SMAGENT\" }]" > $JSON
bash updateAgentGroup.sh "$SMAGENTGROUP" "$JSON"
