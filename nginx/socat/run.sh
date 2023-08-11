#!/bin/bash
set -euf

if [ $# -eq 0 ] ; then
    echo "Usage:"
    echo "  $0 [SPEC]..."
    exit 1
fi

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

    [ -w "$name" ] && rm -- "$name" || true
    echo "I [$0] '$name' -> $host:$port"
    socat -d "UNIX-LISTEN:$name,fork,mode=666" "TCP:$host:$port" &
    PIDS="$PIDS $!"
done

trap "kill -s TERM --timeout 1000 KILL -- $PIDS" EXIT HUP INT TERM

wait
