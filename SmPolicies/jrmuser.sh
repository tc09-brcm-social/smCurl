#!/bin/bash
MYPATH=$(dirname "$0")
NAME=$1
JSON=$(cat)
USER=$(echo "$JSON" | ./jq ".SmUserPolicies | map(select(.UserDirectory.path != \"/SmUserDirectories/$NAME\"))")
echo "$JSON" | ./jq --argjson ud "$USER" '. + {"SmUserPolicies": $ud}' 
