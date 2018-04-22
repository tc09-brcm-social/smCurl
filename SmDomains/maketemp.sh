#!/bin/bash
NAME=$1
echo '#!/bin/bash'
echo 'Name=$1'
echo 'cat <<EOF'
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$NAME" | ./jq -S '.data | del(.id) | .Name = "${Name}"' | bash jqlib/clUDL.sh
echo 'EOF'
