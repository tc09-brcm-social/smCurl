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
ENTNAME=Ridp${NAME}
if EXIST=$(bash ${MYPATH}/../exist.sh "$ENTNAME"); then
    >&2 echo "Error: $ENTNAME already exits, consider using a different NameSuffix"
    usage
    exit
fi
JSON=$$.json
toJson "$FILE" "$JSON"
#
# prepJSON to create
#
ENTID=$(./jq -r '.EntityDescriptor.entityID' "$JSON")
AUTHNR=$(./jq -r '.EntityDescriptor.IDPSSODescriptor.WantAuthnRequestsSigned' "$JSON")
CJSON=$$01.json
echo "{" > "$CJSON"
echo '  "type": "FedIDPRemote",' >> "$CJSON"
echo '  "Name": "'${ENTNAME}'",' >> "$CJSON"
echo '  "Description": "Remote IdP imported from '$FILE'",' >> "$CJSON"
if [ "$AUTHNR" != "null" ]; then
    echo '  "RequireSignedAuthnRequests": '${AUTHNR}',' >> "$CJSON"
fi
echo '  "IdPID": "'${ENTID}'",' >> "$CJSON"
echo '  "NameIDFormat": [' >> "$CJSON"
doNameIDFormats \
    ".EntityDescriptor.IDPSSODescriptor.NameIDFormat" \
    "$JSON" "$CJSON"
echo '  ],' >> "$CJSON"
doCerts "$CERTN" \
    '.EntityDescriptor.IDPSSODescriptor.KeyDescriptor' "$JSON"
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
        echo '  "VerificationCertLink": {' >> "$CJSON"
        echo '    "path": "/FedCertificates/'${SIGNCERT}'"' >> "$CJSON"
        echo '  },' >> "$CJSON"
    fi
    rm "${CERTN}.signing"
fi
echo '   "RemoteSSOServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.IDPSSODescriptor.SingleSignOnService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo ',' >> "$CJSON"
echo '   "RemoteSLOServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.IDPSSODescriptor.SingleLogoutService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo "," >> "$CJSON"
echo '    "RemoteSOAPArtifactResolutionServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.IDPSSODescriptor.ArtifactResolutionService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo "," >> "$CJSON"
echo '    "RemoteAttributeServices": [' >> "$CJSON"
echo '  ]' >> "$CJSON"
echo "," >> "$CJSON"
echo '    "ManageNameIDServices": [' >> "$CJSON"
doRemoteServices \
    ".EntityDescriptor.IDPSSODescriptor.ManageNameIDService" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo ',' >> "$CJSON"
echo '   "SupportedAssertionAttributes": [' >> "$CJSON"
doAttributes \
    ".EntityDescriptor.IDPSSODescriptor.Attribute" \
    "$JSON" "$CJSON"
echo '  ]' >> "$CJSON"
echo "}" >> "$CJSON"
bash FedIdPRemotes/create.sh "$CJSON" | ./jq '.data'
