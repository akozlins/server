#

FROM alpine:edge

EXPOSE 8080

RUN mkdir -p -- "/qbittorrent" && \
    addgroup -g 1000 -S qbittorrent && \
    adduser -u 1000 -S qbittorrent -G qbittorrent && \
    chown -R 1000:1000 -- "/qbittorrent"

RUN apk add --no-cache qbittorrent-nox

USER 1000

ENV HOME="/qbittorrent"
ENV XDG_CONFIG_HOME="$HOME"
ENV XDG_DATA_HOME="$HOME"
ENV XDG_CACHE_HOME="$HOME"

RUN mkdir -p "/qbittorrent/qBittorrent"

CMD qbittorrent-nox
