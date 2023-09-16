#!/bin/bash
set -euf

DOMAIN=$1
USER=${2:-synapse}

echo -n password: && read -rs PASSWORD && echo

curl -X POST "https://$DOMAIN/_matrix/client/r0/login" \
    --data-binary @- << EOF
{
    "type" : "m.login.password",
    "user" : "@$USER:$DOMAIN",
    "password":"$PASSWORD"
}
EOF
