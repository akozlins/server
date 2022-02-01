#!/bin/sh
set -euf

$TTRSS_PHP_EXECUTABLE ./update.php --update-schema=force-yes

cat << EOF > backup.sh
export PGPASSWORD=$TTRSS_DB_PASS
pg_dump --clean --host=$TTRSS_DB_HOST --dbname=$TTRSS_DB_NAME --username=$TTRSS_DB_USER > ./backup-$(date +%Y%m%d).sql
find . -type f -name 'backup-*.sql' -mtime +7 -delete
EOF
chmod +x backup.sh

PIDS=""

php-fpm8 --nodaemonize --force-stderr &
PIDS="$PIDS $!"

$TTRSS_PHP_EXECUTABLE ./update_daemon2.php &
PIDS="$PIDS $!"

crond -l 0 -f &
PIDS="$PIDS $!"

trap "kill --timeout 1000 TERM --signal KILL $PIDS" TERM

wait
