#!/bin/bash
NAME=$1
VALUE=$2
if [[ -z "$NAME" ]]; then
   cat
   exit 1
fi
TOSET=${NAME}=0=${VALUE}
./jq -S --arg n "^${NAME}=" --arg v "${TOSET}" \
    '. | del(.Attributes[] | select(test($n))) | 
         .Attributes += [ $v ]'
