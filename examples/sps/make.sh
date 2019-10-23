#!/bin/bash
#
# This script assumes the User Directory to be used is "CA Directory" and
# the SiteMinder Access Gateway agent name is sps-01.
# You can change them to what you use within your implementation.
# The dir.temp is a template designed for our testing environment.
# If your User Directory has been created, this template will not be used.
# Otherwise, you can choose to modify this template for your own LDAP user directory.
#
MYPWD=$(pwd)
. ./env.shlib
cd ../..
#
# CA Directory
#
SMDIR="CA Directory"
ESCNAME=$(bash utils/escName.sh "$SMDIR")
if ! EXIST=$(bash SmUserDirectories/exist.sh "$ESCNAME"); then
    SMDIRTEMP=SmUserDirectories/temp/dir.temp
    JSON=$$.json
    bash "$SMDIRTEMP" "$SMDIR" "$SMLDAPHOST" "$SMLDAPPORT" | \
        ./jq --arg p "$SMLDAPPWD" '. + { Password: $p }' >"$JSON"
    EXIST=$(bash SmUserDirectories/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
#
# Agent sps-01
#
SMAGENT=sps-01
if ! EXIST=$(bash SmAgents/exist.sh "$SMAGENT"); then
    >&2 echo Access Gateway agent name $SMAGENT may be incorrect.
    exit $?
fi
>&2 echo "Access Gateway Agent $SMAGENT verified"
echo "$EXIST" | ./jq '.data'
#
# SPS Agent Domain
#
SMDOMAIN=DOMAIN-SPSADMINUI-${SMAGENT}
if ! EXIST=$(bash SmDomains/exist.sh "$SMDOMAIN"); then
    >&2 echo "$SMDOMAIN does not exist,"
    >&2 echo "Access Gateway configuration may not have been run"
    exit 1
fi
>&2 echo "Access Gateway Agent Domain $SMDOMAIN verified"
echo "$EXIST" | ./jq '.data'
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
>&2 echo "Access Gateway $SMPOLICY verified"
echo "$EXIST" | ./jq '.data'
#
# add User Directory to Domain
#
ESCNAME=$(bash utils/escName.sh "$SMDIR")
bash SmDomains/adduser.sh "$SMDOMAIN" "$ESCNAME" | ./jq '.data' || exit $?
#
## Variables
#
SMVARNAME1=DeptName1
SMATTRNAME=departmentNumber
JSON=$$.json
if ! EXIST=$(bash SmVariables/exist.sh "$SMDOMAIN" "$SMVARNAME1"); then
    bash SmVariables/temp/attrs255.temp "$SMVARNAME1" "$SMATTRNAME" > "$JSON"
    EXIST=$(bash SmVariables/create.sh "$SMDOMAIN" "$JSON")
fi
echo "$EXIST" | ./jq '.data'
SMVARNAME2=DeptNameAdmin1
SMATTRVALUE=Admin
JSON=$$.json
if ! EXIST=$(bash SmVariables/exist.sh "$SMDOMAIN" "$SMVARNAME2"); then
    bash SmVariables/temp/statics.temp "$SMVARNAME2" "$SMATTRVALUE" > "$JSON"
    EXIST=$(bash SmVariables/create.sh "$SMDOMAIN" "$JSON")
fi
echo "$EXIST" | ./jq '.data'
#
# SPS Policy
#
ESCNAME=$(bash utils/escName.sh "$SMDIR")
ALLUSERS=$(bash SmPolicies/temp/allusers.temp "$ESCNAME")
#./jq '.data| with_entries(select([.key] | inside(["SmUserPolicies", "VariablesLink"])))'
echo "$POLICY" | ./jq '.data' | \
    bash SmPolicies/jadduser.sh "$ALLUSERS" | \
    bash SmPolicies/jaddvar.sh "$SMDOMAIN" "$SMVARNAME2" | \
    bash SmPolicies/jaddvar.sh "$SMDOMAIN" "$SMVARNAME1" | \
    bash SmPolicies/jsetexp.sh "($SMVARNAME2==$SMVARNAME1)" > "$JSON"
bash SmPolicies/update.sh "$SMDOMAIN" "$SMPOLICY" "$JSON" | ./jq '.data'
