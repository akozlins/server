#!/bin/sh
set -euf

export PGPASSWORD=$TTRSS_DB_PASS
PGOPTS="--host=$TTRSS_DB_HOST --dbname=$TTRSS_DB_NAME --username=$TTRSS_DB_USER"

$TTRSS_PHP_EXECUTABLE ./update.php --update-schema=force-yes
psql $PGOPTS -c "create extension if not exists pg_trgm"

PIDS=""

php-fpm8 --nodaemonize --force-stderr &
PIDS="$PIDS $!"

$TTRSS_PHP_EXECUTABLE ./update_daemon2.php &
PIDS="$PIDS $!"

# backup
(
while true ; do
    sleep 30
    echo "I [$0] check"
    if [ -z "$(find ./backup/ -type f -name 'backup.*.sql' -mtime 0)" ] ; then
        echo "I [$0] backup"
        pg_dump $PGOPTS --clean > ./backup/backup.$(date +%FT%T).sql
        find ./backup/ -type f -name 'backup.*.sql' -mtime +7 -delete
    fi
    if [ -r "./backup/restore.sql" ] ; then
        echo "I [$0] backup"
        pg_dump $PGOPTS --clean > ./backup/backup.$(date +%FT%T).sql
        echo "I [$0] restore"
        psql $PGOPTS -c "drop schema public cascade; create schema public;"
        psql $PGOPTS -q < "./backup/restore.sql"
        psql $PGOPTS -c "create extension if not exists pg_trgm"
        mv "./backup/restore.sql" "./backup/restore.$(date +%FT%T).sql"
    fi
done
) &
PIDS="$PIDS $!"

trap "kill --timeout 1000 TERM --signal KILL $PIDS" TERM

wait
