#!/bin/bash
MYPATH=`dirname $0`
NAME=$1
EXIST=`bash "${MYPATH}/exist.sh" "$NAME"`
if [[ $? != 0 ]]; then
    exit 1
fi
echo '#!/bin/bash'
echo 'Name=$1'
echo 'cat <<EOF'
MYPATH=`dirname $0`
#bash "${MYPATH}/read.sh" "$NAME" | ./jq -S '.data | del(.id) | .Name = "${Name}"'
echo "$EXIST" | ./jq '.data' | bash "${MYPATH}/cleanse.sh" | \
	./jq -S '.Name = "${Name}"'
echo 'EOF'
