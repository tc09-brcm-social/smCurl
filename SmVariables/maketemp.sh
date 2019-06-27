#!/bin/bash
MYPATH=`dirname $0`
SMDOMAIN=$1
SMVAR=$2
echo '#!/bin/bash'
echo 'Name=$1'
echo 'cat <<EOF'
bash "${MYPATH}/read.sh" "$SMDOMAIN" "$SMVAR" | \
	./jq '.data + {Name: "$Name" }' | ./jq -f jqlib/rmIHD.jq
echo EOF
