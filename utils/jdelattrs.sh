#!/bin/bash
JSON=$(cat)
OUTPUT=null
for i in $(echo "$JSON" | ./jq -r 'keys[]'); do
    TYPE=$(echo "$JSON" | ./jq -r ".$i | type")
    if [ "$TYPE" == "array" ]; then
        OUTPUT=$(echo "$OUTPUT" | ./jq ". + { $i: []}")
    else
        OUTPUT=$(echo "$OUTPUT" | ./jq ". + { $i: \"\"}")
    fi
done
echo "$OUTPUT"
