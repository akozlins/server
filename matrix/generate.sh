#!/bin/bash
set -euf

# <https://hub.docker.com/r/matrixdotorg/synapse>

docker run -it --rm \
    -v "$(pwd)/data:/data" \
    -e SYNAPSE_SERVER_NAME=example.com \
    -e SYNAPSE_REPORT_STATS=no \
    -e UID=1000 \
    -e GID=1000 \
    matrixdotorg/synapse:latest generate

# register_new_matrix_user http://127.0.0.1:8008 -c /data/homeserver.yaml
