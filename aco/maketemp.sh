#!/bin/bash
# make an aco temp from an existing ACO
cd ..
SMACO=$1
echo '#!/bin/bash'
echo 'SMACO=$1'
echo 'SMAGENT=$2'
echo 'cat <<EOF'
bash nmACO.sh "$SMACO" | ./jq -S '. | del(.id) | del(.Name) | del(.Attributes[] | select(test("DefaultAgentName="))) | .Attributes += ["DefaultAgentName=${SMAGENT}"] | . + {Name: "$SMACO"}'
echo 'EOF'
