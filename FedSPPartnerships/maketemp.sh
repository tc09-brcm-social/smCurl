#!/bin/bash
NAME=$1
MYPATH=$(dirname "$0")
EXIST=$(bash ${MYPATH}/exist.sh "$NAME")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | ./jq '. + { "Name": "${NAME}" }'
echo 'EOF'
