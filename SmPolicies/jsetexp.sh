#!/bin/bash
EXP=$1
./jq --arg v "$EXP" '.VariableExprString = $v'
