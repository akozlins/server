#!/bin/bash
set -euf

if [ $# -eq 0 ] ; then
    echo "Usage:"
    echo "  $0 [SPEC]..."
    exit 1
fi

DIR=/run/socat

PIDS=""
for spec in "$@" ; do
    # number of fields
    nf=$(awk -F: '{print NF}' <<< "$spec")

    if [ "$nf" -gt 3 ] ; then
        >&2 echo "E [$0] spec: invalid format"
        exit 1
    elif [ "$nf" -eq 3 ] ; then
        # `spec` is `name:host:port`
        IFS=: read -r name host port <<< "$spec"
    elif [ "$nf" -eq 2 ] ; then
        # `spec` is `host:port` -> name = port
        IFS=: read -r host port <<< "$spec"
        name="$port"
    elif [ "$nf" -eq 1 ] ; then
        # `spec` is `port` -> name = port, host = 127.0.0.1
        IFS=: read -r port <<< "$spec"
        host="127.0.0.1"
        name="$port"
    fi

    [ -w "$DIR/$name.sock" ] && rm -- "/run/socat/$name.sock" || true
    socat -d "UNIX-LISTEN:$DIR/$name.sock,mode=666,reuseaddr,fork" "TCP:$host:$port" &
    PIDS="$PIDS $!"
done

trap "kill --timeout 1000 TERM --signal KILL $PIDS" TERM

wait
