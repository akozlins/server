#!/bin/bash
set -euf

cd .local || exit 1
export LXR_REPO_DIR="$(pwd)/$1/repo"
export LXR_DATA_DIR="$(pwd)/$1/data"
shift

cd elixir || exit 1
./script.sh list-tags
./script.sh get-latest
./update.py "$@"
