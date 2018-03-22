#!/bin/bash
Alias=$1
echo '#!/bin/bash'
echo 'Alias=$1'
echo 'cat <<EOF'
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$Alias" | ./jq -S '.data | del(.id) | .Alias = "${Alias}"'
echo 'EOF'
