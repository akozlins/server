#

SUDO := $(shell [[ " $$(id --groups --name) " =~ " docker " ]] || echo sudo)

all :

build :
	$(SUDO) docker-compose build --pull

down :
	$(SUDO) docker-compose down

logs :
	$(SUDO) docker-compose logs -f

ps :
	$(SUDO) docker-compose ps

pull :
	$(SUDO) docker-compose pull

restart : | stop start

sh :
	$(SUDO) docker-compose exec $(shell basename -- $(shell pwd)) sh

up :
	$(SUDO) docker-compose up -d
