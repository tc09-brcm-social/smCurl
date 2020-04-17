#!/bin/bash
MYPATH=$(dirname "$0")
FILE=$1
NAME=$2
CERTN=$3
. utils/metadata/metadata.shlib
#
# procedure usage
#
usage() {
    >&2 echo "usage:"
    >&2 echo "bash $0 MetadataFileName NameSuffix CertNamePrefix"
    }
if [ -z "$FILE" ] || [ -z "$NAME" ] || [ -z "$CERTN" ]; then
    >&2 echo "Error: required arguments not supplied fully"
    usage
    exit 1
fi
ENTNAME=Rsp${NAME}
if EXIST=$(bash FedSPRemotes/exist.sh "$ENTNAME"); then
    >&2 echo "Error: $ENTNAME already exits, consider using a different NameSuffix"
    usage
    exit
fi
JSON=$$.json
toJson "$FILE" "$JSON"
#
# prepJSON to create
#
AUTHNR=$(./jq -r '.EntityDescriptor.SPSSODescriptor.AuthnRequestsSigned' "$JSON")
ENTID=$(./jq -r '.EntityDescriptor.entityID' "$JSON")
CJSON=$$01.json
echo "{" > "$CJSON"
echo '  "type": "FedSPRemote",' >> "$CJSON"
echo '  "Name": "'${ENTNAME}'",' >> "$CJSON"
echo '  "Description": "Remote SP imported from '$FILE'",' >> "$CJSON"
if [ "$AUTHNR" != "null" ]; then
    echo '  "SignAuthnRequests": '${AUTHNR}',' >> "$CJSON"
fi
echo '  "SPID": "'${ENTID}'",' >> "$CJSON"
echo '  "NameIDFormat": [' >> "$CJSON"
doNameIDFormats \
    ".EntityDescriptor.SPSSODescriptor.NameIDFormat" \
    "$JSON" "$CJSON"
echo '  ],' >> "$CJSON"
doCerts "$CERTN" \
    '.EntityDescriptor.SPSSODescriptor.KeyDescriptor' "$JSON"
if [ -f "${CERTN}.encryption" ]; then
    if [ "${ENCCERT}" == "" ]; then
        >&2 echo "Warning: unable to import the encryption certificate, skipped"
    else
        echo '  "EncryptionCertificate": {' >> "$CJSON"
        echo '    "path": "/FedCertificates/'${ENCCERT}'"' >> "$CJSON"
        echo '  },' >> "$CJSON"
    fi
    rm "${CERTN}.encryption"
fi
if [ -f "${CERTN}.signing" ]; then
    if [ "${SIGNCERT}" == "" ]; then
        >&2 echo "Warning: unable to import the signing certificate, skipped"
    else
        echo '  "VerificationCertificate": {' >> "$CJSON"
        echo '    "path": "/FedCertificates/'${SIGNCERT}'"' >> "$CJSON"
        echo '  },' >> "$CJSON"
    fi
    rm "${CERTN}.signing"
fi
echo '   "RemoteAssertionConsumerServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.SPSSODescriptor.AssertionConsumerService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo "," >> "$CJSON"
echo '   "SLOServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.SPSSODescriptor.SingleLogoutService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo "," >> "$CJSON"
echo '    "ManageNameIDServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.SPSSODescriptor.ManageNameIDService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo "}" >> "$CJSON"
bash FedSPRemotes/create.sh "$CJSON" | ./jq '.data'
