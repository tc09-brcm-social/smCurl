#!/bin/bash
MYPATH=`dirname $0`
SMOLD=$1
SMNEW=$2
JSON=$$.json
EXIST=`bash "${MYPATH}/exist.sh" "$SMOLD"`
if [[ $? != 0 ]]; then
    exit 1
fi
OLDID=`echo "$EXIST" | ./jq -r '.data.id'`
EXIST=`bash "${MYPATH}/exist.sh" "$SMNEW"`
if [[ $? != 0 ]]; then
    exit 1
fi
echo "$EXIST" | ./jq '.data' | bash "$MYPATH/cleanse.sh" | \
	./jq --arg oldid "$OLDID" --arg oldname "$SMOLD" \
	'.id = $oldid | .Name = $oldname' >"$JSON"
bash "${MYPATH}/update.sh" "$SMOLD" "$JSON"
