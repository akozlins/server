#

FROM node as node_build

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

RUN git clone https://github.com/TwiN/gatus .

ARG VUE_PUBLIC_PATH
RUN sed -i \
    -e "s|publicPath: .*|publicPath: '${VUE_PUBLIC_PATH}'|" \
    web/app/vue.config.js

RUN sed -i \
    -e "s|export const SERVER_URL = .*|export const SERVER_URL = '.'|" \
    web/app/src/main.js

RUN sed -i \
    -e 's|="/|="./|g' \
    web/app/public/index.html

RUN npm --prefix web/app install
RUN npm --prefix web/app run build

FROM golang AS build

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

COPY --from=node_build /home/1000/ .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gatus .

FROM scratch

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

COPY --from=build /home/1000/gatus .
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT [ "./gatus" ]
