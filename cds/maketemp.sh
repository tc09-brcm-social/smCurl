#!/bin/bash
# make an Cds temp from an existing Cds
cd ..
SMCERT=$1
echo '#!/bin/bash'
echo 'SMCERT=$1'
echo 'cat <<EOF'
bash readCdsCerts.sh "$SMCERT" | ./jq -S '.data | del(.id) | del(.Alias) | . + {Alias: "$SMCERT"}'
echo 'EOF'
