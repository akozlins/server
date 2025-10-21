#

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    ca-certificates dumb-init \
    git gcc make libconfig-dev libev-dev libpcre2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/1000
RUN chown -R 1000:1000 .
USER 1000:1000

ARG TAG
RUN git clone https://github.com/yrutschle/sslh --branch=${TAG} .
RUN ./configure && make

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "./sslh-fork", "--foreground", "--listen=0.0.0.0:8080", "--anyprot=127.0.0.1:80", "--on-timeout=anyprot" ]

LABEL com.centurylinklabs.watchtower.enable="false"
