#!/bin/bash
MYPATH=$(dirname "$0")
SMDOMAIN=$1
SMPOL=$2
JSON=$$.json
bash "${MYPATH}"/read.sh "$SMDOMAIN" "$SMPOL" | ./jq '.data' > "$JSON"
UP=$(./jq '.SmUserPolicies[]|[. + {UserDirectory: { path: "/SmUserDirectories/$SMDIR"}}]' "$JSON")
PL='[{ "type": "SmPolicyLink",
        "RuleLink": {
          "path": "/SmDomains/$SMDOMAIN/SmRealms/$SMREALM/SmRules/$SMRULE"
        }
      }]'
echo '#!/bin/bash'
echo 'Name=$1'
echo 'SMDOMAIN=$2'
echo 'SMREALM=$3'
echo 'SMRULE=$4'
echo 'SMDIR=$5'
echo 'cat <<EOF'
bash "${MYPATH}/read.sh" "$SMDOMAIN" "$SMPOL" | \
	./jq --argjson up "$UP" --argjson pl "$PL"\
	      '.data + {Name: "$Name",
	      SmPolicyLinks: $pl,
	      SmUserPolicies: $up }' | ./jq -f jqlib/rmIHD.jq
echo EOF
