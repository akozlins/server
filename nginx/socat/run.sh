#!/bin/sh
set -euf

PIDS=""
for port in "$@" ; do
    rm -v "/run/socat/$port.sock"
    socat -d "UNIX-LISTEN:/run/socat/$port.sock,mode=666,reuseaddr,fork" "TCP:127.0.0.1:$port" &
    PIDS="$PIDS $!"
done

trap "kill --timeout 1000 TERM --signal KILL $PIDS" TERM

wait
