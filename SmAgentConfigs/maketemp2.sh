#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
if ! EXIST=$(bash "${MYPATH}/exist.sh" "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'SMAGENT=$2'
echo 'cat <<EOF'
bash "$MYPATH/normal.sh" "$NAME" | bash "$MYPATH/cleanse.sh" | \
        ./jq -S '. | del(.Attributes[] | select(test("DefaultAgentName="))) | 
             .Attributes += ["DefaultAgentName=0=${SMAGENT}"] | . + {Name: "$NAME"}'
echo 'EOF'
