#

FROM python

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dnsutils dumb-init entr ffmpeg git \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 --no-cache-dir install \
    uv

RUN addgroup --gid 1000 user && adduser --uid 1000 --gid 1000 --home /home/1000 user

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPYCACHEPREFIX="$HOME"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "./main.py" ]

LABEL com.centurylinklabs.watchtower.enable="false"
