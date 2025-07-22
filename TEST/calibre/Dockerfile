#

FROM archlinux

RUN pacman -Sy --noconfirm \
    calibre \
    && pacman -Scc --noconfirm

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

CMD [ "calibre-server", "--listen-on=0.0.0.0", "--url-prefix=/calibre", "--disable-use-bonjour", "--trusted-ips=0.0.0.0/0", ".local/share/calibre" ]

LABEL com.centurylinklabs.watchtower.enable="false"
