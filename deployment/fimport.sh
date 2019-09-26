#!/bin/bash
PWD=$1
XML=$2
MYPATH=$(dirname "$0")
MYBASE=$(basename "${MYPATH}")
JSON=$$.json
echo "$PWD" > "$JSON"
cat "$XML" >> "$JSON"
bash "${MYPATH}/import.sh" "$JSON"
