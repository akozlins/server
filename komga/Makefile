#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -z "$${KOMGA_REMEMBERME_KEY:+x}" ] && echo "KOMGA_REMEMBERME_KEY=$$(pwgen -s 32)" >> .env
