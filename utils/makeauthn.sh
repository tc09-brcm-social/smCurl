#!/bin/bash
. utils/env.shlib
bash utils/authn.sh "$HOST" "$PORT" "$ID" "$PASS" > authn
