#

FROM alpine

RUN apk add --no-cache \
    openssl openvpn

WORKDIR /etc/openvpn

CMD openvpn --config config.conf
