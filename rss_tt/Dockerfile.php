#

FROM alpine

RUN apk add --no-cache \
    dumb-init git postgresql-client

RUN apk add --no-cache \
    php php-fpm \
    php-ctype php-curl php-dom php-fileinfo php-json php-iconv \
    php-intl php-mbstring php-pcntl php-pdo_mysql php-pdo_pgsql php-pdo_sqlite \
    php-posix php-session php-xml php-zip

RUN ln -s -T php81 /etc/php
RUN ln -s -T php-fpm81 /usr/sbin/php-fpm

RUN sed -i \
    -e 's/^\(user\|group\) = .*/\1 = 1000/i' \
    -e 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' \
    -e 's/^\(pm\.max_children\) = .*/\1 = 4/i' \
    -e 's/;\(clear_env\) = .*/\1 = no/i' \
    -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
    -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
    /etc/php/php-fpm.d/www.conf

RUN sed -i \
    -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
    /etc/php/php-fpm.conf

USER 1000:1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "php-fpm", "--nodaemonize", "--force-stderr" ]
