#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
FILE=$2
PWD=$3
CDATA=$(cat "$FILE" | base64 -w0)
JSON=$$.json
bash "${MYPATH}/temp/impp12.temp" "$NAME" | \
    ./jq --arg data "$CDATA" --arg p "$PWD" \
    '. + { Password: $p, CertificateData: $data }' > "$JSON"
bash "${MYPATH}/create.sh" "$JSON"
#./jq --arg data "$CDATA" --arg a "$Name" --arg p "$Pwd" 
#     -n '. + { Alias: $a, Format: "PKCS12", CertificateType: "Certificate", 
#	       Type: "KeyEntry", Password: $p, CertificateData: $data }' 
