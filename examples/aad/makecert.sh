#!/bin/bash
mypwd=`pwd`
cd ../..
index=0
for i in `curl -s https://login.microsoftonline.com/common/discovery/keys | ./jq '.keys  | .[] | [.x5c, .kid]' | grep '"'`
do
    index=$((index+1))
    if [ $((index%2)) -eq 0 ]; then
	JSON=$$.json
	a1="${i%\"}"
	alias="${a1#\"}"
	cert1="${cert%\"}"
	cert2="${cert1#\"}"
	cert4=$"-----BEGIN CERTIFICATE-----\
$cert2\
-----END CERTIFICATE----"
	i3=`echo -n "$cert4" |base64`
	echo '{}' | ./jq --arg bar "$i3" --arg al $alias '. + {Alias: $al, Format: "PEM", CertificateData: $bar, "CertificateType": "Certificate", "type": "FedCertificate"}' > $JSON
	bash FedCertificates/create.sh $JSON
    else
	cert=$i
    fi
done
