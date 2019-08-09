#!/bin/bash
JSONDATA=$1
./jq --argjson u "$JSONDATA" '.SmUserPolicies += [ $u ]'
