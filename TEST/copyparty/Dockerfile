#

FROM archlinux

RUN pacman -Sy --noconfirm \
    copyparty ffmpeg \
    && pacman -Scc --noconfirm

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

ENTRYPOINT [ "copyparty" ]

LABEL com.centurylinklabs.watchtower.enable="false"
