#

FROM php:8-fpm

RUN apt-get update && apt-get --yes --no-install-recommends install \
    dumb-init git postgresql-client \
    libicu-dev libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    pcntl intl pdo_pgsql

RUN sed -i \
    -e 's/^\(user\|group\) = .*/\1 = 1000/i' \
    -e 's/^listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' \
    -e 's/^\(pm\.max_children\) = .*/\1 = 4/i' \
    -e 's/;\(clear_env\) = .*/\1 = no/i' \
    -e 's/;\(php_admin_value\[error_log\]\) = .*/\1 = \/dev\/stderr/' \
    -e 's/;\(php_admin_flag\[log_errors\]\) = .*/\1 = on/' \
    /usr/local/etc/php-fpm.d/www.conf

RUN sed -i \
    -e 's/;\(error_log\) = .*/\1 = \/dev\/stderr/' \
    /usr/local/etc/php-fpm.conf

USER 1000:1000
env PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "php-fpm", "--nodaemonize", "--force-stderr" ]

LABEL com.centurylinklabs.watchtower.enable="false"
