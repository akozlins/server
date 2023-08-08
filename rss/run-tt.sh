#!/bin/sh
set -euf

cd /var/www/tt || exit 1

export PGPASSWORD=$TTRSS_DB_PASS
PGOPTS="--host=$TTRSS_DB_HOST --dbname=$TTRSS_DB_NAME --username=$TTRSS_DB_USER"

# init
./update.php --update-schema=force-yes
psql $PGOPTS -c "create extension if not exists pg_trgm"

PIDS=""

# run php-fpm server (0.0.0.0:9000)
php-fpm --nodaemonize --force-stderr &
PIDS="$PIDS $!"

# run update job
./update_daemon2.php &
PIDS="$PIDS $!"

trap "kill -s TERM --timeout 1000 KILL -- $PIDS" EXIT HUP INT TERM
wait
