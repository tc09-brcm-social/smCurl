#!/bin/bash
HOST=$1
PORT=$2
ID=$3
PASS=$4
BASE64=$(echo -n "$ID:$PASS" | base64)
cat <<EOF
#!/bin/bash
RESTHOST=${HOST}
RESTPORT=${PORT}
EXPIRE=
TOKEN=
if [[ ! -z "\$NOLOGIN" ]] ; then
    return
fi
if [[ -z "\$EXPIRE" || \$(date +%s) -gt \$EXPIRE ]]; then
    TOKEN=\$(curl \${OPT} --header "host: \${RESTHOST}" -k --silent -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'Authorization: Basic ${BASE64}' "https://\${RESTHOST}:\${RESTPORT}/ca/api/sso/services/login/v1/token" | ./jq -r '.sessionkey')
    EXPIRE=\$((\$(date +%s) + 899))
    x=\$(bash utils/setkeyvalue.sh authn EXPIRE "\$EXPIRE")
    x=\$(bash utils/setkeyvalue.sh authn TOKEN "\$TOKEN")
fi
AUTHN="Authorization: Bearer \${TOKEN}"
EOF
