#!/bin/bash
MYPATH=`dirname $0`
SMACO=$1
EXIST=`bash "${MYPATH}/exist.sh" "$SMACO"`
if [[ $? != 0 ]]; then
    exit 1
fi
echo '#!/bin/bash'
echo 'SMACO=$1'
echo 'SMAGENT=$2'
echo 'cat <<EOF'
bash "$MYPATH/normal.sh" "$SMACO" | bash "$MYPATH/cleanse.sh" | \
	./jq -S '. | del(.Attributes[] | select(test("DefaultAgentName="))) | .Attributes += ["DefaultAgentName=0=${SMAGENT}"] | . + {Name: "$SMACO"}'
echo 'EOF'
