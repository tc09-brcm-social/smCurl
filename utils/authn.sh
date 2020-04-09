#!/bin/bash
HOST=$1
PORT=$2
ID=$3
PWD=$4
BASE64=$(echo -n "$ID:$PWD" | base64)
cat <<EOF
#!/bin/bash
RESTHOST=${HOST}
RESTPORT=${PORT}
OPT=
TOKEN=\$(curl \${OPT} --header "host: \${RESTHOST}" -k --silent -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'Authorization: Basic ${BASE64}' "https://\${RESTHOST}:\${RESTPORT}/ca/api/sso/services/login/v1/token" | ./jq -r '.sessionkey')
EOF
