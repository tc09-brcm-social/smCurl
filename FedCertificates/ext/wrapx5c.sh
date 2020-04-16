#!/bin/bash
X5C=$1
echo "-----BEGIN CERTIFICATE-----
$(echo -n "$X5C" | fold -w60)
-----END CERTIFICATE-----"
