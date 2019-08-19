#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
FILE=$2
CDATA=$(cat "$FILE" | base64 -w0)
JSON=$$.json
bash "${MYPATH}/temp/imppem.temp" "$NAME" | \
    ./jq --arg data "$CDATA" '. + { CertificateData: $data }' > "$JSON"
bash "${MYPATH}/create.sh" "$JSON"
# ./jq --arg data "$CDATA" --arg a "$Name" 
#     -n '. + { Alias: $a, Format: "PEM", CertificateType: "Certificate", 
#	       Type: "Certificate", CertificateData: $data }' 
