#

FROM codercom/code-server

RUN sudo apt-get update && sudo apt-get --yes --no-install-recommends install \
    clang clangd cmake ninja-build python \
    && sudo rm -rf /var/lib/apt/lists/*
