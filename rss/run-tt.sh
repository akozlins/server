#!/bin/sh
set -euf

export PGPASSWORD=$TTRSS_DB_PASS
PGOPTS="--host=$TTRSS_DB_HOST --dbname=$TTRSS_DB_NAME --username=$TTRSS_DB_USER"

cd /var/www/tt || exit 1
# init
./update.php --update-schema=force-yes
psql $PGOPTS -c "create extension if not exists pg_trgm"
# run update job
./update_daemon2.php &

# run php-fpm server (0.0.0.0:9000)
php-fpm --nodaemonize --force-stderr &

wait
