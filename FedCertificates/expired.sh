#!/bin/bash
MYPATH=$(dirname "$0")
for i in `bash ${MYPATH}/list.sh | grep Fed | awk 'BEGIN {FS="\""; } {print $2;}' | awk 'BEGIN {FS="/";} {print $3;}'`
do
    MY=`bash ${MYPATH}/read.sh $i | ./jq '.data.ValidTill'`
    MY1="${MY%\"}"
    MYD="${MY1#\"}"
    if [[ `date --date="$MYD" +"%s"` < `date +"%s"` ]]
    then
       echo -n "$i $MY"
    fi
done
