#!/bin/bash
. utils/env.shlib
>&2 echo "Setting up $(PWD)/authn to connect to $HOST $PORT"
bash utils/authn.sh "$HOST" "$PORT" "$ID" "$PASS" > authn
