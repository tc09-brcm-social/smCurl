#!/bin/bash
MYPATH=$(dirname $0)
NAME=$1
CHILD=$2
GCHILD=$3
EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD" "$GCHILD")
STATUS=$?
if [[ "$STATUS" -ne 0 ]]; then
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | ./jq '. + { Name: "${NAME}" }'
echo EOF
