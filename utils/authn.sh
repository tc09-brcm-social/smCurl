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
#
## urlencode taken from
## https://unix.stackexchange.com/questions/60653/urlencode-function
#
urlencode() {
  LC_ALL=C awk -- '
    BEGIN {
      for (i = 1; i <= 255; i++) hex[sprintf("%c", i)] = sprintf("%%%02X", i)
    }
    function urlencode(s,  c,i,r,l) {
      l = length(s)
      for (i = 1; i <= l; i++) {
        c = substr(s, i, 1)
        r = r "" (c ~ /^[-._~0-9a-zA-Z]$/ ? c : hex[c])
      }
      return r
    }
    BEGIN {
      for (i = 1; i < ARGC; i++)
        print urlencode(ARGV[i])
    }' "$@"
}
EOF
