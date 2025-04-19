#

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    curl dumb-init iproute2 iputils-ping socat \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
WORKDIR /run/socat

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
