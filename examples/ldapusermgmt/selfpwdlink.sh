#!/bin/bash
NAME=$1
PASS=$2
MYPATH=$(dirname "$0")
. "${MYPATH}/env.shlib"
echo "https://${AUTHOST}:${AUTHPORT}/siteminderagent/forms/${PWDFCC}?SMENC=UTF-8&USERNAME=${NAME}&P=${NAME}${PASS}&SMAUTHREASON=34&SMAGENTNAME=${SMAGENT}&TARGET=-SM-${ENCURL}"

