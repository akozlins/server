#

include ../makefile.mk

init ::
	# init envs
	[ -f .env ] && source .env
	[ -n "$${ADMIN_PASSWORD:+x}" ] || echo "ADMIN_PASSWORD=$$(pwgen -s 16 1)" >> .env
	# init files
	source .env
	mkdir -p .local && cd .local || exit 1
	[ -f admin_password.key ] || echo "$$ADMIN_PASSWORD" > admin_password.key
