#

FROM node:20 AS build

USER 1000:1000
WORKDIR /home/1000

ARG TAG
RUN git clone -b "$TAG" --depth=1 https://github.com/gchq/CyberChef.git .

RUN npm install

ENV NODE_OPTIONS=--max_old_space_size=2048
RUN npm exec -- grunt prod

# nginx server
FROM nginx

COPY --from=build /home/1000/build/prod /usr/share/nginx/html/cyberchef
