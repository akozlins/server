#

FROM alpine AS build

RUN apk add --no-cache \
    git make gcc
RUN apk add --no-cache \
    libconfig-dev musl-dev pcre2-dev perl

WORKDIR /src
RUN git clone https://github.com/yrutschle/sslh --branch=v1.22 .
RUN make sslh-fork

#

FROM alpine

COPY --from=build /src/sslh-fork /bin/sslh
RUN apk add --no-cache libconfig pcre2

USER nobody

#ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "sslh", "--foreground", "--listen=0.0.0.0:8080", "--anyprot=127.0.0.1:80", "--on-timeout=anyprot" ]
