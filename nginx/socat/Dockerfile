#

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init socat \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /run/socat

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
