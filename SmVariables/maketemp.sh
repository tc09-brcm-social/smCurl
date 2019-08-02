#!/bin/bash
MYPATH=`dirname $0`
NAME=$1
CHILD=$2
EXIST=`bash ${MYPATH}/exist.sh "$NAME" "$CHILD"`
if [[ "$?" != 0 ]]; then
    exit 1
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | ./jq '. + { Name: "${NAME}" }'
echo EOF
