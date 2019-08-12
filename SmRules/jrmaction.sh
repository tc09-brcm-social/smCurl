#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
JSON=$(cat)
ARRAY=$(echo "$JSON" | ./jq ".Actions | map(select(. != \"$NAME\"))")
echo "$JSON" | ./jq --argjson arr "$ARRAY" '. + {"Actions": $arr}' 
