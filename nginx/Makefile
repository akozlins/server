#

include ../makefile.mk

init ::
	mkdir -p .cache/run/socat
	#convert -size 1x1 xc:black -strip .cache/opt/html/favicon.ico

reload :
	docker-compose exec caddy caddy reload --config /etc/caddy/Caddyfile
