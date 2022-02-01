#

FROM alpine:latest

EXPOSE 9000/tcp

WORKDIR /var/www/html/tt-rss

RUN true \
    && apk add --no-cache \
    git php8 php8-fpm postgresql-client \
    && sed -i \
    -e 's/^listen = 127.0.0.1:9000/listen = 9000/' \
    -e 's/;\(clear_env\) = .*/\1 = no/i' \
    -e 's/^\(user\|group\) = .*/\1 = app/i' \
    -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
    -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
    /etc/php8/php-fpm.d/www.conf \
    && sed -i \
    -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
    /etc/php8/php-fpm.conf \
    && addgroup --system --gid 1000 app \
    && adduser --system --uid 1000 app -G app \
    && git clone --depth 1 https://git.tt-rss.org/fox/tt-rss . \
    && chown -R app:app -- .

RUN true \
    && apk add --no-cache \
    php8-curl php8-dom php8-fileinfo php8-json php8-iconv php8-intl \
    php8-mbstring php8-pcntl php8-pdo_pgsql php8-posix php8-session php8-xml \
    php8-zip

RUN ln -s /var/www/html/tt-rss/backup.sh /etc/periodic/15min/backup.sh

USER app

ENV TTRSS_PHP_EXECUTABLE="/usr/bin/php8"

COPY run.sh /bin/
CMD /bin/run.sh
