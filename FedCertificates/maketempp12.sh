#!/bin/bash
NAME=$1
PASSWD=$2
MYPATH=$(dirname "$0")
if [ -z "$PASSWD" ]; then
    >&2 echo "password is required to encrypt certificate"
    exit 1
fi
if ! EXIST=$(bash ${MYPATH}/exist.sh "$NAME"); then
    STATUS=$?
    echo "$EXIST"
    exit "$STATUS"
fi
JSON=$$.json
bash "${MYPATH}/temp/expp12.temp" "$NAME" "$PASSWD" > "$JSON"
CDATA=$(bash "${MYPATH}/export.sh" "$JSON" | ./jq -r '.data.CertificateData')
JSON=$$.json
IMP=$(bash "${MYPATH}/temp/impp12.temp" '$NAME' '$PASSWD' | ./jq --arg d "$CDATA" '. + { CertificateData: $d }')
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'PASSWD=$2'
echo 'cat <<EOF'
echo "$IMP"
echo 'EOF'
