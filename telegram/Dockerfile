#

FROM python:latest

RUN apt update && apt install -y \
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install flask requests

USER 1000:1000
WORKDIR /home/1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "python3", "-u", "main.py" ]
