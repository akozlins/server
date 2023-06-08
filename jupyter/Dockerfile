#

FROM jupyter/scipy-notebook

user root

RUN apt-get update && apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

# grant sudo
#RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/jovyan

user jovyan
