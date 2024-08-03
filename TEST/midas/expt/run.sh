#!/bin/bash
set -euf

export MIDASSYS=/midas
export MIDAS_EXPTAB=/midas/expt/exptab
export MIDAS_EXPT_NAME=test

EXPT_DIR="$(dirname "$MIDAS_EXPTAB")"
mkdir -p -- "$EXPT_DIR"
echo "$MIDAS_EXPT_NAME $EXPT_DIR user" > $MIDAS_EXPTAB

export PATH=$PATH:$MIDASSYS/bin

hostname > "$EXPT_DIR/.SHM_HOST.TXT"

if [ ! -f "$EXPT_DIR/.ODB.SHM" ] ; then
    odbinit -s $((64*1024*1024))
fi

odbedit -c 'create BOOL "WebServer/insecure port passwords" "n"'
odbedit -c         'set "WebServer/insecure port passwords" "n"'
odbedit -c 'create BOOL "WebServer/insecure port host list" "n"'
odbedit -c         'set "WebServer/insecure port host list" "n"'
odbedit -c 'create BOOL "WebServer/Enable insecure port" "y"'
odbedit -c         'set "WebServer/Enable insecure port" "y"'
odbedit -c 'create BOOL "WebServer/Enable IPv6" "n"'
odbedit -c         'set "WebServer/Enable IPv6" "n"'
odbedit -c 'create BOOL "Experiment/Security/Enable non-localhost RPC" "y"'
odbedit -c         'set "Experiment/Security/Enable non-localhost RPC" "y"'
odbedit -c 'create BOOL "Experiment/Security/Disable RPC hosts check" "y"'
odbedit -c         'set "Experiment/Security/Disable RPC hosts check" "y"'

mhttpd &
mserver

wait
