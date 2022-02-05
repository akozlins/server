#

FROM alpine AS build

WORKDIR /src

RUN apk add --no-cache git make gcc && \
    git clone https://github.com/yrutschle/sslh .
RUN apk add --no-cache musl-dev libconfig-dev pcre2-dev && \
    make sslh-select

#

FROM alpine

COPY --from=build /src/sslh-select /sslh
RUN apk add --no-cache libconfig pcre2

USER nobody

ENTRYPOINT [ "/sslh", "-f" ]
