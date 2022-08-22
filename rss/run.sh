#!/bin/sh
set -euf

cd /var/www/html/tt-rss || exit 1

export PGPASSWORD=$TTRSS_DB_PASS
PGOPTS="--host=$TTRSS_DB_HOST --dbname=$TTRSS_DB_NAME --username=$TTRSS_DB_USER"

$TTRSS_PHP_EXECUTABLE ./update.php --update-schema=force-yes
psql $PGOPTS -c "create extension if not exists pg_trgm"

backup () {
    BACKUP="/backup"
    while true ; do
        sleep 30
        echo "I [$0] check"
        if [ -z "$(find "$BACKUP" -type f -name 'backup.*.sql' -mtime 0)" ] || [ -r "$BACKUP/restore.sql" ] ; then
            echo "I [$0] backup"
            pg_dump $PGOPTS > "$BACKUP/backup.$(date +%FT%T).sql"
            find "$BACKUP" -type f -name 'backup.*.sql' -mtime +7 -delete
        fi
        if [ -r "$BACKUP/restore.sql" ] ; then
            echo "I [$0] restore"
            psql $PGOPTS -c "drop schema public cascade; create schema public;"
            psql $PGOPTS -q < "$BACKUP/restore.sql"
            mv "$BACKUP/restore.sql" "$BACKUP/restore.$(date +%FT%T).sql"
        fi
    done
}

PIDS=""

php-fpm8 --nodaemonize --force-stderr &
PIDS="$PIDS $!"

$TTRSS_PHP_EXECUTABLE ./update_daemon2.php &
PIDS="$PIDS $!"

backup &
PIDS="$PIDS $!"

trap "kill --timeout 1000 TERM --signal KILL $PIDS" TERM

wait
