#!/bin/bash
NAME=$1
echo '#!/bin/bash'
echo 'Name=$1'
echo 'cat <<EOF'
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$NAME" | ./jq -S '.data |{type: .type, AgentTypeLink: {path: .AgentTypeLink.path}} | .Name = "${Name}"'
echo 'EOF'
