#!/bin/bash
NAME=$1
VALUE=$2
if [[ -z "$NAME" ]]; then
    cat
    exit 1
fi
JSON=$(cat)
OLD=$(echo "$JSON" | ./jq -r --arg n "^${NAME}=" '.Attributes[] | select(test($n))')
if [[ -z "$OLD" ]]; then
   TOSET=${NAME}=0=${VALUE}
else
   TOSET=${NAME}=2=$(echo "$OLD"| cut -d= -f3)%03${VALUE}
fi
echo "$JSON" | \
    ./jq -S --arg n "^${NAME}=" --arg v "${TOSET}" \
        '. | del(.Attributes[] | select(test($n))) | 
             .Attributes += [ $v ]'
