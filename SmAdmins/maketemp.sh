#!/bin/bash
SMHCO=$1
echo '#!/bin/bash'
echo 'Name=$1'
echo 'cat <<EOF'
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$SMHCO" | ./jq -S '.data | del(.id) | .Name = "${Name}"'
echo 'EOF'
