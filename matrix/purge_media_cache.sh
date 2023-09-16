#!/bin/bash
set -euf

DOMAIN=$1
TOKEN=$2

before_ts=$(date --date='1 months ago' +%s%3N)

curl -X POST \
    "https://$DOMAIN/_synapse/admin/v1/purge_media_cache?before_ts=$before_ts" \
    --header "Authorization: Bearer $TOKEN"
