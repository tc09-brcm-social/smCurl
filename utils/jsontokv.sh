#!/bin/bash
JSONFILE=$1
KEYS=$(./jq 'keys' "$JSONFILE")
LEN=$(echo "$KEYS" | ./jq 'length')
for (( i=0; i < LEN; ++i )); do
    k=$(echo "$KEYS" | ./jq -r ".[$i]")
    eval "$k='$(./jq -r ".$k" "$JSONFILE")'"
done
