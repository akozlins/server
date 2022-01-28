#

FROM rust:latest as build

RUN \
    export RUSTUP_TOOLCHAIN=stable && \
    cargo install --target "x86_64-unknown-linux-gnu" --no-default-features doh-proxy && \
    /usr/local/cargo/bin/doh-proxy --version && \
    true

#

FROM debian:buster-slim

COPY --from=build /usr/local/cargo/bin /usr/local/cargo/bin

RUN \
    useradd doh-proxy && \
    /usr/local/cargo/bin/doh-proxy --version && \
    true
USER doh-proxy

ENV LISTEN=127.0.0.1:8080
ENV SERVER=8.8.8.8:53

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "/usr/local/cargo/bin/doh-proxy --listen-address $LISTEN --server-address $SERVER" ]
