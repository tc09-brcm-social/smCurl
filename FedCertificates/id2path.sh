#!/bin/bash
NAME=$1
MYPATH=$(dirname $0)
bash "${MYPATH}/../objects/nid2path.sh" Alias "$NAME" || exit $?
