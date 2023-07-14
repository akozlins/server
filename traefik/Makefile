#

include ../makefile.mk

init ::
	source .env
	mkdir -p -- ./authelia/.cache
	DOCKER_GID=$$(getent group docker | cut -d: -f3)
	sed -i -e "s/^\(DOCKER_GID\)=.*/\1=$$DOCKER_GID/" --follow-symlinks .env
