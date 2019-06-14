#!/bin/bash
MYPATH=`dirname $0`
Name=$1
File=$2
Pwd=$3
CDATA=`cat "$File" | base64 -w0`
JSON=$$.json
./jq --arg data "$CDATA" --arg a "$Name" --arg p "$Pwd" \
     -n '. + { Alias: $a, Format: "PKCS12", CertificateType: "Certificate", 
	       Type: "KeyEntry", Password: $p, CertificateData: $data }' \
     > "$JSON"
bash "${MYPATH}/create.sh" "$JSON"
