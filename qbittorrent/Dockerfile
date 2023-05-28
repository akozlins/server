#

FROM alpine

RUN apk add --no-cache \
    dumb-init qbittorrent-nox

USER 1000
WORKDIR /home/1000
ENV HOME="/home/1000"
ENV XDG_CONFIG_HOME="$HOME"
ENV XDG_DATA_HOME="$HOME"
ENV XDG_CACHE_HOME="$HOME"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "qbittorrent-nox" ]
