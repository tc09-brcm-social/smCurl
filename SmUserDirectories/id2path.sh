#!/bin/bash
NAME=$1
MYPATH=$(dirname $0)
bash "${MYPATH}/../objects/tid2path.sh" SmUserDirectories "$NAME" || exit $?
