#!/bin/bash
MYPATH=$(dirname "$0")
FILE=$1
. utils/metadata/metadata.shlib
#
# procedure usage
#
usage() {
    >&2 echo "usage:"
    >&2 echo "$0 MetadataFileName NameSuffix CertNamePrefix"
    }
JSON=$$.json
toJson "$FILE" "$JSON"
