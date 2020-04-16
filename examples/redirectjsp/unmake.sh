#!/bin/bash
MYPWD=$(pwd)
cd ../app1
cat "${MYPWD}/env.shlib" >>./env.shlib
echo "AGENT=" >> ./env.shlib
bash unmake.sh
