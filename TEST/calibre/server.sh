#!/bin/bash
set -euf

# <https://manual.calibre-ebook.com/generated/en/calibre-server.html>

touch example.txt
calibredb add example.txt --library-path="$HOME/.local/share/calibre"

calibre-server \
    --listen-on=0.0.0.0 \
    --url-prefix=/calibre \
    --disable-use-bonjour \
    --trusted-ips=0.0.0.0/0 \
    "$HOME/.local/share/calibre"
