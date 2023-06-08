#

FROM alpine

RUN apk add --no-cache \
    dumb-init postgresql-client

RUN apk add --no-cache \
    php php-fpm \
    php-ctype php-curl php-dom php-fileinfo php-json php-iconv \
    php-intl php-mbstring php-pcntl php-pdo_mysql php-pdo_pgsql php-pdo_sqlite \
    php-posix php-session php-xml php-zip

RUN sed -i \
    -e 's/^\(user\|group\) = .*/\1 = 1000/i' \
    -e 's/^listen = 127.0.0.1:9000/listen = 9000/' \
    -e 's/^\(pm\.max_children\) = .*/\1 = 4/i' \
    -e 's/;\(clear_env\) = .*/\1 = no/i' \
    -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
    -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
    /etc/php81/php-fpm.d/www.conf

RUN sed -i \
    -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
    /etc/php81/php-fpm.conf

USER 1000:1000

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "php-fpm81", "--nodaemonize", "--force-stderr" ]
