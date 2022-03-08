#!/bin/bash
NOLOGIN=1
. ./authn
./jq -n '
{ "expire" :'" $(( $EXPIRE - $(date '+%s') ))"',
  "token" : "'"$TOKEN"'"}'
