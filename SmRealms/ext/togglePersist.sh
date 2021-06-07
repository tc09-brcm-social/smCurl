#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
CHILD=$2
if ! EXIST=$(bash "${MYPATH}/../exist.sh" "$NAME" "$CHILD") ; then
    >&2 echo "$CHILD of $NAME does not exist."
    exit 1
fi
JSON=$$.json
ST=$(echo "$EXIST" | ./jq -r '.data.SessionType')
if [ "$ST" = "Non-peristent" ]; then
    ST=Peristent
else
    ST=Non-peristent
fi
echo "{ \"SessionType\": \"$ST\" }" > "$JSON"
bash SmRealms/update.sh "$NAME" "$CHILD" "$JSON"
