#!/bin/bash
NAME=$1
MYPATH=`dirname $0`
bash "${MYPATH}/../objects/tid2path.sh" SmUserDirectories "$NAME"
if [[ "$?" != 1 ]]; then
    exit 1
fi
