#

FROM alpine

EXPOSE 9000/tcp

WORKDIR /var/www/html/tt-rss

RUN apk add --no-cache git && \
    git clone --depth 1 https://git.tt-rss.org/fox/tt-rss .

RUN apk add --no-cache \
        postgresql-client \
        php8 php8-curl php8-dom php8-fileinfo php8-fpm php8-json php8-iconv \
        php8-intl php8-mbstring php8-pcntl php8-pdo_pgsql php8-posix \
        php8-session php8-xml php8-zip && \
    sed -i \
        -e 's/^listen = 127.0.0.1:9000/listen = 9000/' \
        -e 's/;\(clear_env\) = .*/\1 = no/i' \
        -e 's/^\(user\|group\) = .*/\1 = app/i' \
        -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
        -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
        /etc/php8/php-fpm.d/www.conf && \
    sed -i \
        -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
        /etc/php8/php-fpm.conf

ENV TTRSS_RUN_DIR=/var/run/tt-rss
ENV TTRSS_CACHE_DIR="$TTRSS_RUN_DIR/cache"
ENV TTRSS_LOCK_DIRECTORY="$TTRSS_RUN_DIR/lock"
ENV TTRSS_ICONS_DIR="$TTRSS_RUN_DIR/feed-icons"

RUN mkdir -p -- "$TTRSS_RUN_DIR" && \
    cp -r -t "$TTRSS_RUN_DIR" ./cache ./lock ./feed-icons && \
    addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app && \
    chown -R app:app -- "$TTRSS_RUN_DIR"

COPY run.sh "$TTRSS_RUN_DIR"

ENV TTRSS_PHP_EXECUTABLE=/usr/bin/php8

USER app

CMD "$TTRSS_RUN_DIR/run.sh"
