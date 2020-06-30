#!/bin/bash
LIST=$1
while IFS=',' read -ra ADDR; do
    for i in "${ADDR[@]}"; do
        eval "$i"
    done
done <<< "$LIST"
