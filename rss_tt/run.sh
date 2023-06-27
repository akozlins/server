#!/bin/sh
set -euf

cd /var/www/tt-rss || exit 1

export PGPASSWORD=$TTRSS_DB_PASS
PGOPTS="--host=$TTRSS_DB_HOST --dbname=$TTRSS_DB_NAME --username=$TTRSS_DB_USER"

$TTRSS_PHP_EXECUTABLE ./update.php --update-schema=force-yes
psql $PGOPTS -c "create extension if not exists pg_trgm"

PIDS=""

# run php-fpm server (0.0.0.0:9000)
php-fpm --nodaemonize --force-stderr &
PIDS="$PIDS $!"

# run update job
$TTRSS_PHP_EXECUTABLE ./update_daemon2.php &
PIDS="$PIDS $!"

trap "kill -s TERM --timeout 1000 KILL -- $PIDS" SIGHUP SIGINT SIGTERM
wait
