#!/bin/bash
set -euf

if [[ $# < 2 ]] ; then
    echo "Usage:"
    echo "  $0 [options] [<address> <address>]..."
    exit 1
fi

OPTS=()
while [[ "${1:-}" = -* ]] ; do
    OPTS+=("$1")
    shift 1
done

while [ $# -ge 2 ] ; do
    socat "${OPTS[@]}" "$1" "$2" &
    shift 2
done

wait
