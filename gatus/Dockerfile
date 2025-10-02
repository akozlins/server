#

FROM node:23 as node_build

WORKDIR /home/1000
RUN chown 1000:1000 .
USER 1000:1000
ENV HOME="/home/1000"

RUN git clone https://github.com/TwiN/gatus .

ARG VUE_PUBLIC_PATH=/gatus
RUN sed -i \
    -e "s|publicPath: .*|publicPath: '${VUE_PUBLIC_PATH}'|" \
    web/app/vue.config.js

RUN sed -i \
    -e "s|export const SERVER_URL = .*|export const SERVER_URL = '.'|" \
    web/app/src/main.js

RUN sed -i \
    -e 's|="/|="./|g' \
    web/app/public/index.html

RUN npm --ignore-scripts --prefix web/app install
RUN npm --ignore-scripts --prefix web/app run build
RUN npm prune --omit=dev

FROM golang AS build

WORKDIR /home/1000
RUN chown 1000:1000 .
USER 1000:1000
ENV HOME="/home/1000"

COPY --from=node_build /home/1000/ .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gatus .

FROM scratch

WORKDIR /home/1000
#RUN chown 1000:1000 .
USER 1000:1000
ENV HOME="/home/1000"

COPY --from=build /home/1000/gatus .
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT [ "./gatus" ]

LABEL com.centurylinklabs.watchtower.enable="false"
