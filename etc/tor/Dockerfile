#

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init tor \
    curl iproute2 nano \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "tor", "--SocksPort", "0.0.0.0:1080" ]
