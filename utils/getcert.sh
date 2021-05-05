#!/bin/bash
NAME=$1
if [[ ! -z "$2" ]]; then
    PORT=:$2
else
    PORT=:443
fi
echo | openssl s_client -servername $NAME -connect $NAME$PORT | \
    sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
