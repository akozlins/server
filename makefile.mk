#

build :
	sudo docker-compose build

down :
	sudo docker-compose down

sh :
	sudo docker-compose exec $(shell basename -- $(shell pwd)) sh

logs :
	sudo docker-compose logs -f

ps :
	sudo docker-compose ps

pull :
	sudo docker-compose pull

restart : | stop start

up :
	sudo docker-compose up -d



start : up

stop : down
