#

FROM golang:alpine AS build

WORKDIR /src

RUN apk add --no-cache git make && \
    git clone https://github.com/m13253/dns-over-https . && \
    make doh-server/doh-server

#

FROM alpine

EXPOSE 8053

COPY --from=build /src/doh-server/doh-server /doh-server

USER nobody

ENTRYPOINT ["/doh-server"]
CMD ["-conf", "/doh-server.conf"]
