#!/bin/bash
MYPATH=`dirname $0`
Name=$1
JSON=$$.json
bash "${MYPATH}"/read.sh "$Name" | ./jq '.data' > "$JSON"
SO=`./jq '.SignatureOptions + {VerificationCertificate: {path: "/FedCertificates/$IDPCERT"}, 
	SigningPrivateKey: {path: "/FedCertificates/$SPCERT"}}' "$JSON"`
EO=`./jq '.EncryptionOptions + {
	DecryptionPrivateKey: {path: "/FedCertificates/$SPCERT"}}' "$JSON"`
PU=`./jq '.Policy.SmUserPolicies[] | [. + {UserDirectory: { path: "/SmUserDirectories/$UD" }}]' "$JSON"`
P=`./jq --argjson pu "$PU" '.Policy + { SmUserPolicies: $pu }' "$JSON"`
UD=` ./jq '.UserDirectories[] | [{path: "/SmUserDirectories/$UD"}]' "$JSON"`
DESC="Template from SP to IDP $Name through $0"
echo '#!/bin/bash'
echo 'Name=$1'
echo 'LSP=$2'
echo 'RIDP=$3'
echo 'SPCERT=$4'
echo 'IDPCERT=$5'
echo 'UD=$6'
echo 'cat <<EOF'
./jq --argjson so "$SO" --argjson eo "$EO" --argjson p "$P" --argjson ud "$UD" \
	--arg desc "$DESC" '. + {Name: "$Name",
	Description: $desc,
	RemoteIdPEntityName: "$RIDP",
	LocalSPEntityName: "$LSP",
	Policy: $p,
	UserDirectories: $ud,
	SignatureOptions: $so,
	EncryptionOptions: $eo }' "$JSON" | ./jq -f jqlib/rmIHD.jq
echo 'EOF'
