#!/bin/bash
MYPATH=`dirname $0`
SMACO=$1
echo '#!/bin/bash'
echo 'SMACO=$1'
echo 'SMAGENT=$2'
echo 'cat <<EOF'
bash "$MYPATH/normal.sh" "$SMACO" | ./jq -S '. | del(.id) | del(.Name) | del(.Attributes[] | select(test("DefaultAgentName="))) | .Attributes += ["DefaultAgentName=${SMAGENT}"] | . + {Name: "$SMACO"}'
echo 'EOF'
