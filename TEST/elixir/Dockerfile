#

FROM python

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init lighttpd \
    python3-bsddb3 python3-jinja2 \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

RUN git clone https://github.com/bootlin/elixir.git

#RUN pip3 --no-cache-dir install \
#    bsddb3 jinja2

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "lighttpd", "-D", "-f", "lighttpd.conf" ]
