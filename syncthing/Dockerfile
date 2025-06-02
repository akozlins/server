#

FROM archlinux

RUN pacman -Sy --noconfirm \
    syncthing \
    && pacman -Scc --noconfirm

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

ENTRYPOINT [ "syncthing" ]

LABEL com.centurylinklabs.watchtower.enable="false"
