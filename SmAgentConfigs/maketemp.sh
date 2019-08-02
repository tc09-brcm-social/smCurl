#!/bin/bash
NAME=$1
MYPATH=`dirname $0`
EXIST=`bash ${MYPATH}/exist.sh "$NAME"`
if [[ "$?" != 0 ]]; then
    exit 1
fi
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | ./jq '. + { Name: "${NAME}" }'
echo 'EOF'
