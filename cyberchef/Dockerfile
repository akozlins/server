#

FROM node:19 AS build

USER 1000
WORKDIR /tmp/1000

ARG TAG
RUN git clone -b "$TAG" --depth=1 https://github.com/gchq/CyberChef.git .

RUN npm install

ENV NODE_OPTIONS=--max_old_space_size=2048
RUN npm exec -- grunt prod

FROM nginx:alpine
EXPOSE 80

COPY --from=build /tmp/1000/build/prod /usr/share/nginx/html/cyberchef
