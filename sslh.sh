#!/bin/sh

exec \
/bin/sslh \
    --listen=127.0.0.1:1443 \
    --ssh=127.0.0.1:22 \
    --openvpn=127.0.0.1:1194 \
    --anyprot=127.0.0.1:1194 \
    --on-timeout=anyprot \
    "$@"
