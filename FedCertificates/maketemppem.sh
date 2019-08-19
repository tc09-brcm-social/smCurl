#!/bin/bash
NAME=$1
MYPATH=$(dirname "$0")
if ! EXIST=$(bash ${MYPATH}/exist.sh "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
JSON=$$.json
bash "${MYPATH}/temp/exppem.temp" "$NAME" > "$JSON"
CDATA=$(bash "${MYPATH}/export.sh" "$JSON" | ./jq -r '.data.CertificateData')
JSON=$$.json
IMP=$(bash "${MYPATH}/temp/imppem.temp" '$NAME' | ./jq --arg d "$CDATA" '. + { CertificateData: $d }')
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$IMP"
echo 'EOF'
