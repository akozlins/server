#!/bin/sh
set -euf

cd /var/www/fresh || exit 1

# make needed dirs in ./data
./cli/prepare.php
# init
./cli/reconfigure.php --auth_type none --default_user default --db-type sqlite
# create user
./cli/user-info.php --user default || ./cli/create-user.php --user default

PIDS=""

# run php-fpm server (0.0.0.0:9000)
php-fpm --nodaemonize --force-stderr &
PIDS="$PIDS $!"

# run update job
( while true ; do
    php ./app/actualize_script.php
    sleep 1801
done ) &
PIDS="$PIDS $!"

trap "kill -s TERM --timeout 1000 KILL -- $PIDS" EXIT HUP INT TERM
wait