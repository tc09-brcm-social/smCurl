#!/bin/bash
MYPATH=$(dirname "$0")
ID=$1
bash "${MYPATH}/../objects/id2path.sh" "${ID}"
