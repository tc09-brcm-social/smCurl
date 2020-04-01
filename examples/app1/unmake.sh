#!/bin/bash
# Assume User Directory ${DIRECTORY} pre-existed and not to be removed
# Assume we always use the AllowGetPost Rule
# Assume we always apply AllowGetPost to all users, policy name is All
. ./env.shlib
cd ../..
##
### Domain
##
SMDOMAIN=${DOMAIN}
##
### Policy
##
SMPOLICY=All
EXIST=$(bash SmPolicies/exist.sh "$SMDOMAIN" "$SMPOLICY")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Policy $SMPOLICY of $SMDOMAIN does not exist, skipping ..."
else
    >2& echo "removing Policy $SMPOLICY of $SMDOMAIN"
    bash SmPolicies/delete.sh "$SMDOMAIN" "$SMPOLICY"
fi
##
### Realm
##
SMREALM=${REALM}
##
### Rule
##
SMRULE=AllowGetPost
EXIST=$(bash SmRules/exist.sh "$SMDOMAIN" "$SMREALM" "$SMRULE")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Rule $SMRULE of $SMREALM of $SMDOMAIN does not exist, skipping ..."
else
    >2& echo "Removing Rule $SMRULE of $SMREALM of $SMDOMAIN"
    bash SmRules/delete.sh "$SMDOMAIN" "$SMREALM" "$SMRULE"
fi
##
### Realm
##
EXIST=$(bash SmRealms/exist.sh "$SMDOMAIN" "$SMREALM")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Realm $SMREALM of $SMDOMAIN does not exist, skipping ..."
else
    >2& echo "Removing Realm $SMREALM of $SMDOMAIN"
    bash SmRealms/delete.sh "$SMDOMAIN" "$SMREALM"
fi
##
### Agent
##
SMAGENT=${AGENT}
EXIST=$(bash SmAgents/exist.sh "$SMAGENT")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Agent $SMAGENT does not exist, skipping ..."
else
    >2& echo "Removing Agent $SMAGENT"
    bash SmAgents/delete.sh "$SMAGENT"
fi
##
### AgentGroup
##
SMAGENTGROUP=${GROUP}
EXIST=$(bash SmAgentGroups/exist.sh "$SMAGENTGROUP")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Agent Group $SMAGENTGROUP does not exist, skipping ..."
else
    >2& echo "Removing Agent Group $SMAGENTGROUP"
    bash SmAgentGroups/delete.sh "$SMAGENTGROUP"
fi
##
### Domain
##
EXIST=$(bash SmDomains/exist.sh "$SMDOMAIN")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Domain $SMDOMAIN does not exist, skipping ..."
else
    >2& echo "Removing Domain $SMDOMAIN"
    bash SmDomains/delete.sh "$SMDOMAIN"
fi
##
### Authe Scheme
##
SMAUTH=${AUTHSCHEME}
EXIST=$(bash SmAuthSchemes/exist.sh "$SMAUTH")
STATUS=$?
if [ "$STATUS" -ne 0 ]; then
    >2& echo "Auth Scheme $SMAUTH does not exist, skipping ..."
else
    >2& echo "Removing Auth Scheme $SMAUTH"
    bash SmAuthSchemes/delete.sh "$SMAUTH"
fi
