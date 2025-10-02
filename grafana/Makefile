#

include ../makefile.mk

reload :
	docker-compose kill -s SIGHUP prometheus

prometheus-snapshot :
	sudo docker compose exec prometheus \
	    wget -qO- --post-data="" http://127.0.0.1:9090/prometheus/api/v1/admin/tsdb/snapshot

vm-prometheus-import :
	sudo docker run -it \
	    --volume=.local/prometheus:/prometheus:ro \
	    --network=grafana_default \
	    victoriametrics/vmctl -- \
	    prometheus --prom-snapshot /prometheus/data/snapshots/$(SNAPSHOT) \
	    --vm-addr=http://victoria:8428/victoria/
