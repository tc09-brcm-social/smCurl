#!/bin/bash
MYPATH=`dirname $0`
Name=$1
JSON=$$.json
bash "${MYPATH}/read.sh" "$Name" | ./jq '.data | del(.RemoteSPEntityName) | del(.LocalIdPEntityName) | .Status = "Inactive"' > "$JSON"
bash "${MYPATH}/update.sh" "$Name" "$JSON"
