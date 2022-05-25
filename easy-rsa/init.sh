#!/bin/bash
set -euf

# <https://easy-rsa.readthedocs.io/en/latest/advanced/>

export EASYRSA=/etc/easy-rsa
export EASYRSA_PKI="$(pwd)/pki"

cat > "$EASYRSA_PKI/vars" << EOF
#set_var EASYRSA_ALGO ec
#set_var EASYRSA_CURVE secp521r1
#set_var EASYRSA_DIGEST "sha512"
#set_var EASYRSA_NS_SUPPORT "yes"
set_var EASYRSA_REQ_CN example
EOF

if [ ! -f dh.pem ] ; then
    openssl dhparam 2048 > "$EASYRSA_PKI/dh.pem"
    openvpn --genkey secret "$EASYRSA_PKI/ta.key"
fi

faketime -f "$(date --date='20200101 GMT' --rfc-3339=ns)" easyrsa --batch init-pki

# ca
#echo "set_var EASYRSA_REQ_CN '$1'" > "$EASYRSA_PKI/vars"
sed -e "s/\(set_var EASYRSA_REQ_CN\) .*/\1 '$1'/" -i "$EASYRSA_PKI/vars"
faketime -f "$(date --date='20200101 GMT' --rfc-3339=ns)" easyrsa --batch --days=3650 build-ca nopass
