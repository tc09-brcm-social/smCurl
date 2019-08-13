#!/bin/bash
MYPWD=$(pwd)
cd ../..
#
# CA Directory
#
SMDIR="CA Directory"
SMLDAPHOST=$(hostname)
SMLDAPPORT=20589
SMDIRTEMP=${MYPWD}/dir.temp
JSON=$$.json
ESCNAME=$(bash utils/escName.sh "$SMDIR")
if EXIST=$(bash SmUserDirectories/exist.sh "$ESCNAME"); then
    echo "$EXIST"
else
    bash "$SMDIRTEMP" "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT" >"$JSON"
    bash SmUserDirectories/create.sh "$JSON"
fi
#
# Agent sps-01
#
SMAGENT=sps-01
if ! EXIST=$(bash SmAgents/exist.sh "$SMAGENT"); then
    >&2 echo Access Gateway agent name $SMAGENT may be incorrect.
    exit $?
fi
echo "Access Gateway Agent $SMAGENT verified"
echo "$EXIST"
#
# SPS Agent Domain
#
SMDOMAIN=DOMAIN-SPSADMINUI-${SMAGENT}
if ! EXIST=$(bash SmDomains/exist.sh "$SMDOMAIN"); then
    >&2 echo "$SMDOMAIN does not exist,"
    >&2 echo "Access Gateway configuration may not have been run"
    exit 1
fi
echo "Access Gateway Agent Domain $SMDOMAIN verified"
echo "$EXIST"
#
# SPS Agent Domain Policy
#
SMPOLICY=POLICY-SPSADMINUI-${SMAGENT}
JSON=$$.json
if ! POLICY=$(bash SmPolicies/exist.sh "$SMDOMAIN" "$SMPOLICY"); then
    >&2 echo $SMPOLICY does not exist
    >&2 echo "Access Gateway configuration may have been modified"
    exit 1
fi
echo "Access Gateway $SMPOLICY verified"
#
# add User Directory to Domain
#
ESCNAME=$(bash utils/escName.sh "$SMDIR")
bash SmDomains/adduser.sh "$SMDOMAIN" "$ESCNAME" || exit $?
#
## Variables
#
SMVARNAME1=DeptName1
SMATTRNAME=departmentNumber
JSON=$$.json
if EXIST=$(bash SmVariables/exist.sh "$SMDOMAIN" "$SMVARNAME1"); then
    echo "$EXIST"
else
    bash SmVariables/temp/attrs255.temp "$SMVARNAME1" "$SMATTRNAME" > "$JSON"
    bash SmVariables/create.sh "$SMDOMAIN" "$JSON"
fi
SMVARNAME2=DeptNameAdmin1
SMATTRVALUE=Admin
JSON=$$.json
if EXIST=$(bash SmVariables/exist.sh "$SMDOMAIN" "$SMVARNAME2"); then
    echo "$EXIST"
else
    bash SmVariables/temp/statics.temp "$SMVARNAME2" "$SMATTRVALUE" > "$JSON"
    bash SmVariables/create.sh "$SMDOMAIN" "$JSON"
fi
#
# SPS Policy
#
ESCNAME=$(bash utils/escName.sh "$SMDIR")
ALLUSERS=$(bash SmPolicies/temp/allusers.temp "$ESCNAME")
echo "$POLICY" | ./jq '.data' | \
    bash SmPolicies/jadduser.sh "$ALLUSERS" | \
    bash SmPolicies/jaddvar.sh "$SMDOMAIN" "$SMVARNAME2" | \
    bash SmPolicies/jaddvar.sh "$SMDOMAIN" "$SMVARNAME1" | \
    bash SmPolicies/jsetexp.sh "($SMVARNAME2==$SMVARNAME1)" > "$JSON"
bash SmPolicies/update.sh "$SMDOMAIN" "$SMPOLICY" "$JSON"
