#

.ONESHELL :
SHELL := bash
.SHELLFLAGS := -euf -c

SUDO := $(shell [[ " $$(id --groups --name) " =~ " docker " ]] || echo sudo)

all :

build :
	$(SUDO) docker-compose build

down :
	$(SUDO) docker-compose down

logs :
	$(SUDO) docker-compose logs --follow

br-traefik :
	$(SUDO) docker network create \
	    --internal \
	    --subnet="172.31.255.0/24" \
	    --opt "com.docker.network.bridge.name=br-traefik" \
	    traefik
	# allow connection only from traefik container in traefik network
	sudo iptables -I DOCKER-USER -i br-traefik -o br-traefik ! -s 172.31.255.254 -m conntrack --ctstate NEW -j REJECT

networks :
	fq_expr=".networks | select(. != null) | to_entries[] | select(.value.external == true) | .key"
	networks=(
	    $$(comm -2 -3 <(fq --raw-output -- "$$fq_expr" docker-compose.yml | sort | uniq) <($(SUDO) docker network ls --format='{{.Name}}' | sort | uniq))
	)
	for network in "$${networks[@]}" ; do
	    $(SUDO) docker network create --internal "$$network"
	done

ps :
	$(SUDO) docker-compose ps

pull :
	$(SUDO) docker-compose pull

restart : | stop start

sh :
	$(SUDO) docker-compose exec $(shell basename -- $(shell pwd)) sh

up : init
	$(SUDO) docker-compose up -d

.PHONY : init
init ::
