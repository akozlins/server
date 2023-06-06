#

FROM alpine

RUN apk add --no-cache openssl openvpn

WORKDIR /etc/openvpn/server

#RUN openssl dhparam 2048 > "dh.pem"
#RUN openvpn --genkey secret "ta.key"

CMD openvpn --config server.conf
