#

FROM golang AS build

RUN apt-get update && apt-get --yes --no-install-recommends install \
    git \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

RUN git clone https://github.com/v2fly/v2ray-core .
RUN CGO_ENABLED=0 go build -o ./v2ray -trimpath -ldflags "-s -w -buildid=" ./main

FROM debian

RUN apt-get update && apt-get --yes --no-install-recommends install \
    ca-certificates curl dumb-init entr gettext \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

COPY --from=build /home/1000/v2ray .

RUN curl -L https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat -o geosite.dat
RUN curl -L https://github.com/v2fly/geoip/releases/latest/download/geoip.dat -o geoip.dat

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
#CMD ./v2ray run -config=/etc/v2ray/config.json
CMD echo /etc/v2ray/config.json | entr -nrsz "envsubst < /etc/v2ray/config.json | ./v2ray run"
