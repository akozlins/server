#

FROM node:23 AS build

USER 1000:1000
WORKDIR /home/1000

#RUN git clone --depth=1 https://github.com/Niek/chatgpt-web .
COPY .local/chatgpt-web/ .

RUN npm ci
RUN npm run build

#

# http server
FROM caddy

COPY --from=build /home/1000/dist /opt/html

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
