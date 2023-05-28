#

FROM node:19-alpine

# <https://github.com/louislam/uptime-kuma/blob/master/docker/alpine-base.dockerfile>
RUN apk add --no-cache \
    git \
    iputils setpriv dumb-init python3 py3-cryptography py3-pip py3-six py3-yaml py3-click py3-markdown py3-requests py3-requests-oauthlib
RUN pip3 --no-cache-dir install apprise==1.2.1

USER 1000
WORKDIR /app

RUN git clone -b "1.18.5" --depth=1 https://github.com/louislam/uptime-kuma.git .
# <https://github.com/louislam/uptime-kuma/pull/1092>
RUN wget https://patch-diff.githubusercontent.com/raw/louislam/uptime-kuma/pull/1092.diff
RUN git apply 1092.diff

RUN npm ci --omit=dev

RUN npm install vite vite-plugin-legacy
RUN npx vite build --config ./config/vite.config.js

VOLUME [ "/app/data" ]
ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "node", "server/server.js" ]
