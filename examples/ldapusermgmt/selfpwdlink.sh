#!/bin/bash
NAME=$1
PASS=$2
DIRNAME=$(cd $(dirname "$0"); pwd)
cd ../..
. "${DIRNAME}/env.shlib" "${DIRNAME}"
echo "https://${AUTHOST}:${AUTHPORT}/siteminderagent/forms/${PWDFCC}?SMENC=UTF-8&USERNAME=${NAME}&P=${NAME}${PASS}&SMAUTHREASON=34&SMAGENTNAME=${SMAGENT}&TARGET=-SM-${ENCURL}"

