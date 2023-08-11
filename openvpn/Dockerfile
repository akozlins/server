#

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    openssl openvpn \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /etc/openvpn

CMD openvpn --config config.conf
