#!/bin/bash
NAME=$1
if [[ -z "$NAME" ]]; then
   cat
   exit 1
fi
./jq -S --arg n "^${NAME}=" \
    '. | del(.Attributes[] | select(test($n)))'
