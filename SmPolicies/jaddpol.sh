#!/bin/bash
JSONDATA=$1
./jq --argjson p "$JSONDATA" '.SmPolicyLinks += [ $p ]'
