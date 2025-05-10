#

FROM codercom/code-server

RUN apt-get update && sudo apt-get --yes --no-install-recommends install \
    clang clangd cmake ninja-build make python3 \
    && sudo rm -rf /var/lib/apt/lists/*
