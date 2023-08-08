#

FROM python

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 --no-cache-dir install \
    flask requests waitress

USER 1000:1000
WORKDIR /home/1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "python3", "-u", "main.py" ]
