#

FROM jupyter/scipy-notebook

user root

RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

user 1000
