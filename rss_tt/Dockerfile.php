#

FROM alpine

EXPOSE 9000/tcp

RUN apk add --no-cache \
        php8 php8-curl php8-dom php8-fileinfo php8-fpm php8-json php8-iconv \
        php8-intl php8-mbstring php8-pcntl php8-pdo_pgsql php8-posix \
        php8-session php8-xml php8-zip && \
    sed -i \
        -e 's/^\(user\|group\) = .*/\1 = php/i' \
        -e 's/^listen = 127.0.0.1:9000/listen = 9000/' \
        -e 's/^\(pm\.max_children\) = .*/\1 = 16/i' \
        -e 's/;\(clear_env\) = .*/\1 = no/i' \
        -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
        -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
        /etc/php8/php-fpm.d/www.conf && \
    sed -i \
        -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
        /etc/php8/php-fpm.conf

RUN apk add --no-cache \
    dumb-init git postgresql-client

RUN addgroup -g 1000 -S php && \
    adduser -u 1000 -S php -G php

USER 1000:1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
