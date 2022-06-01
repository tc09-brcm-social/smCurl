#!/bin/bash
. ./env.shlib
#
# CA Directory
#
SMDIR="CA Directory"
ESCNAME=$(bash utils/escName.sh "$SMDIR")
if ! EXIST=$(bash SmUserDirectories/exist.sh "$ESCNAME"); then
    >&2 echo "User Directory $SMDIR does not exist, skipped"
else
    >&2 echo "Removing User Directory $SMDIR"
    bash SmUserDirectories/delete.sh "$ESCNAME"
fi
