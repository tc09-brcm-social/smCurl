#!/bin/bash
Name=$1
echo '#!/bin/bash'
echo 'Name=$1'
echo 'cat <<EOF'
MYPATH=`dirname $0`
bash "${MYPATH}/read.sh" "$Name" | ./jq '.data | { Alias: "${Name}", CertificateData: .CertificateData, Format: "PEM", CertificateType: .CertificateType, type: .type} '
echo 'EOF'
