#

all :

build :
	sudo docker-compose build

down :
	sudo docker-compose down

logs :
	sudo docker-compose logs -f

ps :
	sudo docker-compose ps

pull :
	sudo docker-compose pull

restart : | stop start

sh :
	sudo docker-compose exec $(shell basename -- $(shell pwd)) sh

up :
	sudo docker-compose up -d
