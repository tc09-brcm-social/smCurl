#!/bin/bash
. ./env.shlib
#
# CA Directory
#
ESCNAME=$(bash utils/escName.sh "$SMDIR")
if ! EXIST=$(bash SmUserDirectories/exist.sh "$ESCNAME"); then
    JSON=$$.json
    bash "$SMDIRTEMP" "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT" | \
        ./jq --arg p "$SMLDAPPWD" '. + { Password: $p }' >"$JSON"
    EXIST=$(bash SmUserDirectories/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
