#!/bin/bash
MYPATH=$(dirname $0)
NAME=$1
CHILD=$2
if ! EXIST=$(bash ${MYPATH}/exist.sh "$NAME" "$CHILD"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | ./jq '. + { Name: "${NAME}" }'
echo EOF
