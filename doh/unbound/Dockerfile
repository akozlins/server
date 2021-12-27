FROM alpine:latest

EXPOSE 53/tcp
EXPOSE 53/udp

RUN apk add --no-cache unbound openssl

WORKDIR /etc/unbound

COPY unbound.conf my_unbound.conf
RUN echo 'include: "/etc/unbound/my_unbound.conf"' >> unbound.conf

CMD unbound
