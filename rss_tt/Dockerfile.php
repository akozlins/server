#

FROM alpine

RUN apk add --no-cache \
    dumb-init postgresql-client

RUN apk add --no-cache \
    php8 php8-fpm \
    php8-ctype php8-curl php8-dom php8-fileinfo php8-json php8-iconv \
    php8-intl php8-mbstring php8-pcntl php-pdo_mysql php8-pdo_pgsql php-pdo_sqlite \
    php8-posix php8-session php8-xml php8-zip

RUN sed -i \
    -e 's/^\(user\|group\) = .*/\1 = 1000/i' \
    -e 's/^listen = 127.0.0.1:9000/listen = 9000/' \
    -e 's/^\(pm\.max_children\) = .*/\1 = 16/i' \
    -e 's/;\(clear_env\) = .*/\1 = no/i' \
    -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
    -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
    /etc/php8/php-fpm.d/www.conf

RUN sed -i \
    -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
    /etc/php8/php-fpm.conf

USER 1000:1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "php-fpm8", "--nodaemonize", "--force-stderr" ]
