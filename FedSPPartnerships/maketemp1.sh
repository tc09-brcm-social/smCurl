#!/bin/bash
MYPATH=`dirname $0`
Name=$1
JSON=$$.json
bash ${MYPATH}/read.sh "$Name" | ./jq '.data' > "$JSON"
SO=`./jq '.SignatureOptions + {VerificationCertificate: {path: "/FedCertificates/$SPCERT"}, 
	SigningPrivateKey: {path: "/FedCertificates/$IDPCERT"}}' "$JSON"`
EOC=`./jq '.EncryptionOptions.EncryptionConfiguration + {
	EncryptionCertificate: {path: "/FedCertificates/$SPCERT"}}' "$JSON"`
EO=`./jq --argjson eoc "$EOC" '.EncryptionOptions + 
	{EncryptionConfiguration: $eoc}' "$JSON"`
PU=`./jq '.Policy.SmUserPolicies[] | [. + {UserDirectory: { path: "/SmUserDirectories/$UD" }}]' "$JSON"`
P=`./jq --argjson pu "$PU" '.Policy + { SmUserPolicies: $pu }' "$JSON"`
UD=` ./jq '.UserDirectories[] | [{path: "/SmUserDirectories/$UD"}]' "$JSON"`
DESC="Template from IDP to SP $Name through $0"
echo '#!/bin/bash'
echo 'Name=$1'
echo 'LIDP=$2'
echo 'RSP=$3'
echo 'IDPCERT=$4'
echo 'SPCERT=$5'
echo 'UD=$6'
echo 'cat <<EOF'
./jq --argjson so "$SO" --argjson eo "$EO" --argjson p "$P" --argjson ud "$UD" \
        --arg desc "$DESC" '. + {Name: "$Name",
        Description: $desc,
	RemoteSPEntityName: "$RSP",
	LocalIdPEntityName: "$LIDP",
	Policy: $p,
	UserDirectories: $ud,
	SignatureOptions: $so,
	EncryptionOptions: $eo }' "$JSON" | ./jq -f jqlib/rmIHD.jq
echo 'EOF'
