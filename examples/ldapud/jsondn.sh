#!/bin/bash
SPEC=$1
DIRNAME=$(cd $(dirname $0); pwd)
cd ../..
SSOHOME=$(pwd)
cd "$DIRNAME"
LIST="[]"
for i in $(bash searchldap.sh "$SPEC" dn | grep '^dn:' | sed 's/^dn://' ) ; do
    LIST=$(echo "$LIST" | "${SSOHOME}/jq" ". + [\"$i\"]")
done
echo "$LIST"
