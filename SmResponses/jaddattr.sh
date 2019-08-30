#!/bin/bash
JSONDATA=$1
./jq --argjson a "$JSONDATA" '.SmResponseAttrs += [ $a ]'
