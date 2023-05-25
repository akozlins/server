#!/bin/bash
set -euf

export EASYRSA=/etc/easy-rsa
export EASYRSA_PKI="$(pwd)/pki"

while [[ $# > 0 ]] ; do
#    echo "set_var EASYRSA_REQ_CN '$1'" > "$EASYRSA_PKI/vars"
    sed -e "s/\(set_var EASYRSA_REQ_CN\) .*/\1 '$1'/" -i "$EASYRSA_PKI/vars"
    faketime -f "$(date --date='20200101 GMT' --rfc-3339=ns)" easyrsa --batch --days=3650 gen-req "$1" nopass
    faketime -f "$(date --date='20200101 GMT' --rfc-3339=ns)" easyrsa --batch --days=3650 sign-req server "$1"
    shift
done
