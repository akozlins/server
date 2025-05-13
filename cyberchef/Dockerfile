#

FROM node:21 AS build

WORKDIR /home/1000
RUN chown 1000:1000 .
USER 1000:1000

ARG TAG="v10.19.4"
RUN git clone -b "$TAG" --depth=1 https://github.com/gchq/CyberChef.git .

ENV NODE_OPTIONS=--max_old_space_size=2048
RUN npm ci
RUN npm run build

# http server
FROM caddy

COPY --from=build /home/1000/build/prod /opt/html/cyberchef

RUN <<EOF cat > /etc/caddy/Caddyfile
{
    admin off
    auto_https off
    log error {
        level DEBUG
        include http.log.error
    }
    persist_config off
}
:80 {
    root * /opt/html
    file_server
}
EOF
