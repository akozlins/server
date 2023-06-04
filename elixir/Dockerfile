#

FROM python:latest

RUN apt-get update -y
RUN apt-get install -y lighttpd
RUN apt-get install -y python3-bsddb3 python3-jinja2

USER 1000:1000
WORKDIR /home/1000
ENV HOME="/home/1000"

RUN git clone https://github.com/bootlin/elixir.git

#RUN pip install bsddb3 jinja2

CMD lighttpd -D -f lighttpd.conf
