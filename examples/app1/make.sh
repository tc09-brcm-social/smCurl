#!/bin/bash
# Assume User Directory ${DIRECTORY} exists
# Assume we always use the AllowGetPost Rule
# Assume we always apply AllowGetPost to all users, policy name is All
. ./env.shlib
MYPWD=$(pwd)
cd ../..
##
### User Directory
##
SMDIR=${DIRECTORY}
EXIST=$(bash SmUserDirectories/exist.sh "$SMDIR")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "User Directory ${SMDIR} does not exist, quitting ..."
    exit ${STATUS}
fi
echo "$EXIST" | ./jq '.data'
##
### Authe Scheme
##
SMAUTH=${AUTHSCHEME}
EXIST=$(bash SmAuthSchemes/exist.sh "$SMAUTH")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    SMAUTHTEMP=SmAuthSchemes/temp/formauth.temp
    JSON=$$.json
    bash "$SMAUTHTEMP" "$SMAUTH" > "$JSON"
    EXIST=$(bash SmAuthSchemes/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
##
### Domain
##
SMDOMAIN=${DOMAIN}
EXIST=$(bash SmDomains/exist.sh "$SMDOMAIN")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    SMDIR=${DIRECTORY}
    SMDOMAINTEMP=SmDomains/temp/domain0.temp
    JSON=$$.json
    bash "$SMDOMAINTEMP" "$SMDOMAIN" "$SMDIR" >"$JSON"
    EXIST=$(bash SmDomains/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
##
### AgentGroup and Agent member
##
SMAGENTGROUP=${GROUP}
EXIST=$(bash SmAgentGroups/exist.sh "$SMAGENTGROUP")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    JSON=$$.json
    bash SmAgentGroups/temp/ag.temp "$SMAGENTGROUP" > "$JSON"
    EXIST=$(bash SmAgentGroups/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
SMAGENT=${AGENT}
EXIST=$(bash SmAgents/exist.sh "$SMAGENT")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    JSON=$$.json
    bash SmAgents/temp/agent.temp "$SMAGENT" > "$JSON"
    EXIST=$(bash SmAgents/create.sh "$JSON")
fi
echo "$EXIST" | ./jq '.data'
EXIST=$(bash SmAgentGroups/addagent.sh "$SMAGENTGROUP" "$SMAGENT")
echo "$EXIST" | ./jq '.data'
##
### Realm
##
SMREALM=${REALM}
EXIST=$(bash SmRealms/exist.sh "$SMDOMAIN" "$SMREALM")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    APPVDIR=${VDIR}
    JSON=$$.json
    bash "SmRealms/temp/realmAG0.temp" "$SMREALM" "$APPVDIR" "$SMAGENTGROUP" "$SMAUTH" > "$JSON"
    EXIST=$(bash SmRealms/create.sh "$SMDOMAIN" "$JSON")
fi
echo "$EXIST" | ./jq '.data'
##
### Rule
##
SMRULE=AllowGetPost
EXIST=$(bash SmRules/exist.sh "$SMDOMAIN" "$SMREALM" "$SMRULE")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    EXIST=$(bash SmRules/create.sh "$SMDOMAIN" "$SMREALM" "SmRules/temp/${SMRULE}.json")
fi
echo "$EXIST" | ./jq '.data'
##
### Policy
##
SMPOLICY=All
EXIST=$(bash SmPolicies/exist.sh "$SMDOMAIN" "$SMPOLICY")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    JSON=$$.json
    bash SmPolicies/temp/policy.temp "$SMPOLICY" "$SMDOMAIN" "$SMREALM" "$SMRULE" "$SMDIR" > "$JSON"
    EXIST=$(bash SmPolicies/create.sh "$SMDOMAIN" "$JSON")
fi
echo "$EXIST" | ./jq '.data'
