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

CMD [ "sslh", "-f", "--listen=0.0.0.0:443", "--anyprot=0.0.0.0:443", "--on-timeout=anyprot" ]
