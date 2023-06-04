#

FROM alpine

RUN apk add --no-cache \
    dumb-init qbittorrent-nox

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

RUN mkdir -p ".cache/qBittorrent" ".config/qBittorrent" ".local/share/qBittorrent/logs"
RUN ln -s -T /dev/stdout .local/share/qBittorrent/logs/qbittorrent.log

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "qbittorrent-nox" ]
