#

FROM alpine AS build

RUN apk add --no-cache git make gcc
RUN apk add --no-cache musl-dev libconfig-dev pcre2-dev

WORKDIR /src
RUN git clone https://github.com/yrutschle/sslh --branch=v1.22 .
RUN make sslh-select

#

FROM alpine

COPY --from=build /src/sslh-select /sslh
RUN apk add --no-cache libconfig pcre2

USER nobody

ENTRYPOINT [ "/sslh", "-f" ]
