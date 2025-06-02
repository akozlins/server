#

FROM python

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 --no-cache-dir install \
    uv \
    flask requests waitress

RUN addgroup --gid 1000 user && adduser --uid 1000 --gid 1000 --home /home/1000 user

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "python3", "-u", "main.py" ]

LABEL com.centurylinklabs.watchtower.enable="false"
