#!/bin/bash
PWD=$1
XML=$2
MYPATH=$(dirname "$0")
MYBASE=$(basename "${MYPATH}")
MXML=$$.mxml
echo "$PWD" > "$MXML"
cat "$XML" >> "$MXML"
bash "${MYPATH}/import.sh" "$MXML"
