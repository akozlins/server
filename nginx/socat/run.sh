#!/bin/bash
set -euf

PIDS=""
for spec in "$@" ; do
    nf=1
    if [ "$nf" -gt 1 ] ; then
        exit 1
    elif [ "$nf" -eq 1 ] ; then
        port="$spec"
        host="127.0.0.1"
        name="$port"
    fi

    rm -- "/run/socat/$name.sock" || true
    socat -d "UNIX-LISTEN:./$name.sock,mode=666,reuseaddr,fork" "TCP:$host:$port" &
    PIDS="$PIDS $!"
done

trap "kill --timeout 1000 TERM --signal KILL $PIDS" TERM

wait
