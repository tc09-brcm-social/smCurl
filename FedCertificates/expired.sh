#!/bin/bash
MYPATH=$(dirname "$0")
OFFSET=$1
if [[ -z "$OFFSET" ]]; then
    OFFSET=0
fi
TD=$(date +"%s")
EXP=$(( $OFFSET * 86400 + $TD ))
LIST=$(bash ${MYPATH}/list.sh)
EXPLIST=$(./jq -n '. + []')
for i in $(seq  $(echo "$LIST" | ./jq 'length')); do
    CERTPATH=$(echo "$LIST" | ./jq -r ".[$(( $i - 1 ))]")
    CERT=$(basename $CERTPATH)
    MYD=$(bash "$MYPATH/read.sh" $CERT | ./jq  -r '.data.ValidTill')
    if [[ $(date --date="$MYD" +"%s") < $EXP ]]; then
       EXPLIST=$(echo "$EXPLIST" | ./jq ". + [{ Name: \"$CERT\", ValidTill: \"$MYD\"}]")
    fi
done
echo "$EXPLIST"
