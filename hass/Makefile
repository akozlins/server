#

include ../makefile.mk

TOKEN:=

influxdb-passwd :
	sudo docker-compose exec influxdb \
	    influx user password -n hass \
	    -t ${TOKEN}

.PHONY : python
python :
	sudo docker compose run --rm python bash

.PHONY : backup
backup :
	name=".local.$$(hostname).$$(date --utc +%Y%m%d)"
	tar --exclude='.npm' --exclude='node_modules' -cf "./$$(name).tar" .local

.PHONY : influx2raw
influx2raw :
	sudo docker compose exec influxdb \
	    influx query \
	    'from(bucket: "hass") |> range(start: 0) |> drop(columns: ["_start", "_stop"])' \
	    --raw \
	    | gzip > influx.gz
