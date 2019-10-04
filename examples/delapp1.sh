#!/bin/bash
cd ..
##
### Domain
##
SMDOMAIN=${NS}Demo1
##
### Policy
##
SMPOLICY=All
bash SmPolicies/delete.sh "$SMDOMAIN" "$SMPOLICY"
##
### Realm
##
SMREALM=Demoapp1Realm
##
### Rule
##
SMRULE=AllowGetPost
bash SmRules/delete.sh "$SMDOMAIN" "$SMREALM" "$SMRULE"
##
### Realm
##
bash SmRealms/delete.sh "$SMDOMAIN" "$SMREALM"
##
### AgentGroup
##
SMAGENTGROUP=wsGroup1
bash SmAgentGroups/delete.sh "$SMAGENTGROUP"
##
### Domain
##
bash SmDomains/delete.sh "$SMDOMAIN"
##
### Authe Scheme
##
SMAUTH=${NS}demoauth1
bash SmAuthSchemes/delete.sh "$SMAUTH"
