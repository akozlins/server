#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -z "$${ADMIN_PASSWORD:+x}" ] && echo "ADMIN_PASSWORD=$$(pwgen -s 16)" >> .env
	
	source .env
	mkdir -p .local && cd .local || exit 1
	[ -f admin_password.key ] || echo "$$ADMIN_PASSWORD" > admin_password.key
