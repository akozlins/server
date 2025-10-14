#

include ../makefile.mk

init ::
	mkdir -p -- .local/redis authelia/.cache

authelia_client_secret :
	sudo docker-compose exec authelia \
	    authelia crypto hash generate pbkdf2 --variant sha512 --iterations 100000 \
	    --password $CLIENT_SECRET

test :
	curl -v -H 'Cookie:authelia_session_$(MACHINE_ID)=$(AUTHELIA_COOKIE)' https://$(HOST).$(DOMAIN)/whoami/
