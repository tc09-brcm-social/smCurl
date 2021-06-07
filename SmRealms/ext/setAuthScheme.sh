#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
AUTH=$3
if ! EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME" "$CHILD") ; then
    >&2 echo "$CHILD of $NAME does not exist."
    exit 1
fi
if ! EXIST=$(bash "SmAuthSchemes/exist.sh" "$AUTH") ; then
    >&2 echo "$AUTH does not exist"
    exit 1
fi
JSON=$$.json
bash SmAuthSchemes/id2path.sh \
    $(echo "$EXIST" | ./jq -r '.data.id')\
    | ./jq '.[0] | { "AuthSchemeLink": . }' > "$JSON"
bash SmRealms/update.sh "$NAME" "$CHILD" "$JSON"
