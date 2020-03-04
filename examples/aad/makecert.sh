#!/bin/bash
#
# makecert.sh - import certificates from Microsoft Azure MetadataURL
# https://docs.microsoft.com/en-us/azure/active-directory/develop/access-tokens
#
# It creates certificates using kid as the certificate alias.
#
cd ../..
METADATAURL=https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration
#v1.0 METADATAURL=https://login.microsoftonline.com/common/.well-known/openid-configuration
JWKSURL=$(curl ${OPT} --header "host: ${RESTHOST}" -s "$METADATAURL" | ./jq -r '.jwks_uri')
KEYS=$(curl ${OPT} --header "host: ${RESTHOST}" -s "$JWKSURL" | ./jq '.keys')
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
