FROM alpine:latest

EXPOSE 1053/tcp
EXPOSE 1053/udp

RUN apk add --no-cache unbound openssl

WORKDIR /etc/unbound

RUN echo 'include: "/etc/unbound/conf.d/*.conf"' >> unbound.conf

CMD unbound
