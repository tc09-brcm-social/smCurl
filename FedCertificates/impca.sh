#!/bin/bash
MYPATH=`dirname $0`
Name=$1
File=$2
CDATA=`cat "$File" | base64 -w0`
JSON=$$.json
./jq --arg data "$CDATA" --arg a "$Name" \
     -n '. + { Alias: $a, Format: "PEM", CertificateType: "Certificate", 
	       Type: "TrustedCA", CertificateData: $data }' \
     > "$JSON"
bash "${MYPATH}/create.sh" "$JSON"
