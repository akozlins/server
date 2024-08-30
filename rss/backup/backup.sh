#!/bin/sh
set -euf

if [ $# -eq 0 ] ; then
    set -- "--host=127.0.0.1" "--dbname=$POSTGRES_DB" "--username=$POSTGRES_USER"
fi

echo "I [$0] check"
pg_isready "$@"

unset CDPATH
cd "$(dirname -- "$(readlink -f -- "$0")")" || exit 1

# backup daily or if need to restore
if [ -z "$(find "./" -type f -name 'backup.*.sql' -mtime 0)" ] || [ -r "./restore.sql" ] ; then
    echo "I [$0] backup"
    touch "./backup.sql~" && chown 1000:1000 "./backup.sql~"
    pg_dump "$@" > "./backup.sql~"
    mv "./backup.sql~" "./backup.$(date +%FT%T).sql"
    find "./" -type f -name 'backup.*.sql' -mtime +7 -delete
fi

# restore from `restore.sql`
if [ -r "./restore.sql" ] ; then
    echo "I [$0] restore"
    psql "$@" -c "drop schema public cascade; create schema public;"
    psql "$@" -q < "./restore.sql"
    mv -- "./restore.sql" "./restore.$(date +%FT%T).sql"
fi
