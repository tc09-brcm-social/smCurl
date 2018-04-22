#!/bin/bash
MYPATH=`dirname $0`
SMDOMAIN=$1
UD=$2
JSON=$$.json
bash "${MYPATH}/read.sh" ${SMDOMAIN} | ./jq ".data | .UserDirectoriesLink += [{ \"path\" : \"/SmUserDirectories/$UD\" }]" > "$JSON"
bash "${MYPATH}/update.sh" ${SMDOMAIN} "$JSON"
