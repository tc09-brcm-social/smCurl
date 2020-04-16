#!/bin/bash
MYPWD=$(pwd)
cd ../app1
cat "${MYPWD}/env.shlib" >>./env.shlib
bash make.sh
