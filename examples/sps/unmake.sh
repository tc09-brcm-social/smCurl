#!/bin/bash
MYPWD=$(pwd)
. ./env.shlib > /dev/null
cd ../..
#
# Agent sps-01
#
SMAGENT=sps-01
if ! EXIST=$(bash SmAgents/exist.sh "$SMAGENT"); then
    >&2 echo Access Gateway agent name $SMAGENT may be incorrect.
    exit $?
fi
>&2 echo "Access Gateway agent ${SMAGENT} verified."
echo "$EXIST" | ./jq '.data'
#
# SPS Agent Domain
#
SMDOMAIN=DOMAIN-SPSADMINUI-${SMAGENT}
if ! DOMAIN=$(bash SmDomains/exist.sh "$SMDOMAIN"); then
    >&2 echo "$SMDOMAIN does not exist,"
    >&2 echo "Access Gateway configuration may not have been run"
    exit 1
fi
>&2 echo "Access Gateway Policy Domain ${SMDOMAIN} verified."
echo "$DOMAIN" | ./jq '.data'
#
# SPS Policy
#
SMPOLICY=POLICY-SPSADMINUI-${SMAGENT}
JSON=$$.json
if ! EXIST=$(bash SmPolicies/exist.sh "$SMDOMAIN" "$SMPOLICY"); then
    STATUS=$?
    >&2 echo $SMPOLICY does not exist
    echo "$EXIST"
    exit "$STATUS"
fi
>&2 echo "Access Gateway Domain Policy ${SMPOLICY} checked."
echo "$EXIST" | ./jq '.data'
>&2 echo "removing Users and Expression from $SMPOLICY"
JSON=$$.json
echo "$EXIST" | ./jq '.data' \
    | bash SmPolicies/junsetexp.sh | bash SmPolicies/junsetvars.sh \
    | bash SmPolicies/junsetusers.sh > "$JSON"
bash SmPolicies/update.sh "$SMDOMAIN" "$SMPOLICY" "$JSON" | ./jq '.data'
#
# SPS Variables
#
>&2 echo "removing Variables from $SMDOMAIN"
SMVARNAME=DeptName1
bash SmVariables/delete.sh "$SMDOMAIN" "$SMVARNAME"
SMVARNAME=DeptNameAdmin1
bash SmVariables/delete.sh "$SMDOMAIN" "$SMVARNAME"
#
# SPS Agent Domain User Directory
#
>&2 echo "removing User Directories from $SMDOMAIN"
JSON=$$.json
echo "$DOMAIN" | ./jq '.data' | bash SmDomains/junsetusers.sh > "$JSON"
bash SmDomains/update.sh "$SMDOMAIN" "$JSON" | ./jq '.data'
