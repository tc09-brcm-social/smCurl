#!/bin/bash
FNAME=$1
MYPATH=$(dirname "$0")
SHA1=$(openssl x509 -in "$FNAME" -noout -fingerprint | awk 'BEGIN {FS="=";} /SHA1/ {print $2;}')
LIST=$(bash "${MYPATH}/../list.sh")
LENGTH=$(echo "$LIST" | ./jq 'length')
for (( i = 0; i < $LENGTH; ++i )); do
    NAME=$(echo "$LIST" | ./jq -r ".[$i]" | awk 'BEGIN {FS="/";} {print $3;}')
    CERT=$(bash "$MYPATH/../exist.sh" "$NAME")
    if [ $(echo "$CERT" | ./jq -r '.data.SHA1Fingerprint') == "$SHA1" ]; then
        echo "$NAME"
        exit
    fi
done
