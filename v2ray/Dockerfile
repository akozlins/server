#

FROM golang:alpine AS build

RUN apk add --no-cache \
    git

USER 1000
ENV HOME=/home/1000
WORKDIR /home/1000

RUN git clone https://github.com/v2fly/v2ray-core .
RUN CGO_ENABLED=0 go build -o ./v2ray -trimpath -ldflags "-s -w -buildid=" ./main

FROM alpine

RUN apk add --no-cache \
    dumb-init entr gettext

USER 1000
ENV HOME=/home/1000
WORKDIR /home/1000

COPY --from=build /home/1000/v2ray .

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
#CMD ./v2ray run -config=/etc/v2ray/config.json
CMD echo /etc/v2ray/config.json | entr -nrsz "envsubst < /etc/v2ray/config.json | ./v2ray run"