#!/bin/bash
#
# makecert.sh - import certificates from OpenID Connect Metadata URL
#
# It creates certificates using kid as the certificate alias.
#
. ./env.shlib
cd ../..
JWKSURL=$(curl -s "$METADATAURL" | ./jq -r '.jwks_uri')
KEYS=$(curl -s "$JWKSURL" | ./jq '.keys')
for i in $(seq $(echo "$KEYS" | ./jq 'length')); do
    KID=$(echo "$KEYS" | ./jq -r ".[$(($i - 1))].kid")
    if ! EXIST=$(bash FedCertificates/exist.sh "$KID"); then
        CERT=$(echo "$KEYS" | ./jq -r ".[$(($i - 1))].x5c | .[0]")
        PEMFILE=$$.pem
        bash FedCertificates/ext/wrapx5c.sh "$CERT" > "$PEMFILE"
        EXIST=$(bash FedCertificates/imppem.sh "$KID" "$PEMFILE")
    fi
    echo "$EXIST" | ./jq '.data'
done
