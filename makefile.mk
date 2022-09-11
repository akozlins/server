#

up :
	sudo docker-compose up -d

down :
	sudo docker-compose down

logs :
	sudo docker-compose logs -f

start : up

stop : down

restart : | stop start

pull :
	sudo docker-coupose pull
