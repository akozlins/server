#

FROM alpine

RUN apk add --no-cache \
    bash dumb-init socat

WORKDIR /run/socat

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
