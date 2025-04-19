#

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init sslh \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
WORKDIR /home/1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "sslh", "--foreground", "--listen=0.0.0.0:8080", "--anyprot=127.0.0.1:80", "--on-timeout=anyprot" ]
