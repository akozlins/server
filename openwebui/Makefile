#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -n "$${OAUTH_SESSION_TOKEN_ENCRYPTION_KEY:+x}" ] || echo "OAUTH_SESSION_TOKEN_ENCRYPTION_KEY=$$(pwgen -s 32 1)" >> .env
	[ -n "$${WEBUI_SECRET_KEY:+x}" ] || echo "WEBUI_SECRET_KEY=$$(pwgen -s 32 1)" >> .env
