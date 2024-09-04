#

.ONESHELL :
SHELL := bash
.SHELLFLAGS := -euf -c

ENVS := \
    HOST=$(shell hostname) \
    DOCKER_GID=$(shell getent group docker | cut -d: -f3) \
    MACHINE_ID=$(shell cat /etc/machine-id) \
    HOME=$(HOME)
SUDO := $(ENVS) $(shell [[ " $$(id --groups --name) " =~ " docker " ]] || echo sudo)

all :

build :
	$(SUDO) docker-compose build --pull

down :
	$(SUDO) docker-compose down --remove-orphans

logs :
	$(SUDO) docker-compose logs --follow

# traefik bridge network
br-traefik :
	source .env
	docker network ls | grep -w traefik || \
	$(SUDO) docker network create \
	    --internal \
	    --subnet="$$TRAEFIK_SUBNET.0/24" \
	    --opt "com.docker.network.bridge.name=br-traefik" \
	    --opt "com.docker.network.bridge.enable_icc=false" \
	    traefik
	# allow connections only from traefik container in traefik network
	RULE="DOCKER-USER -i br-traefik -o br-traefik -s $$TRAEFIK_SUBNET.254 -d $$TRAEFIK_SUBNET.0/24 -m conntrack --ctstate NEW -j ACCEPT"
	sudo iptables -C $$RULE || sudo iptables -I $$RULE

# internet bridge network
br-inet :
	source .env
	docker network ls | grep -w inet || \
	$(SUDO) docker network create \
	    --subnet="$$INET_SUBNET.0/24" \
	    --opt "com.docker.network.bridge.name=br-inet" \
	    --opt "com.docker.network.bridge.enable_icc=false" \
	    inet
	RULE="DOCKER-USER -i br-inet -o br-inet -s $$INET_SUBNET.0/24 -d $$INET_SUBNET.254 -m conntrack --ctstate NEW -j ACCEPT"
	sudo iptables -C $$RULE || sudo iptables -I $$RULE

networks : br-traefik br-inet
	fq_expr=".networks | select(. != null) | to_entries[] | select(.value.external == true) | .key"
	networks=($$(
	    comm -2 -3 \
	    <(fq --raw-output -- "$$fq_expr" docker-compose.yml | sort | uniq) \
	    <($(SUDO) docker network ls --format='{{.Name}}' | sort | uniq)
	))
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
