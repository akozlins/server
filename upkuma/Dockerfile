#

FROM node:19 AS build

# <https://github.com/louislam/uptime-kuma/blob/master/docker/>
RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init \
    python3 python3-pip \
    python3-click python3-markdown python3-requests-oauthlib python3-yaml \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 --no-cache-dir install \
    apprise==1.2.1

USER 1000:1000
WORKDIR /home/1000

RUN git clone -b "1.18.5" --depth=1 https://github.com/louislam/uptime-kuma.git .
# <https://github.com/louislam/uptime-kuma/pull/1092>
RUN wget https://patch-diff.githubusercontent.com/raw/louislam/uptime-kuma/pull/1092.diff
RUN git apply 1092.diff

RUN npm ci --omit=dev

RUN npm install vite vite-plugin-legacy
RUN npx vite build --config ./config/vite.config.js

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "node", "server/server.js" ]
