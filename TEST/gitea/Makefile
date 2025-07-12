#

include ../makefile.mk

init ::
	source .env
	mkdir -p -- .local/gitea
	# <https://docs.gitea.com/next/administration/config-cheat-sheet>
	sed --in-place \
	    -e '/^ENABLE_REVERSE_PROXY_AUTHENTICATION *=/d' \
	    -e '/^ENABLE_REVERSE_PROXY_AUTO_REGISTRATION *=/d' \
	    -e '/^REVERSE_PROXY_AUTHENTICATION_USER *=/d' \
	    -e '/^REVERSE_PROXY_AUTHENTICATION_EMAIL *=/d' \
	    .local/gitea/app.ini
	sed --in-place \
	    -e '/^\[service\]/a ENABLE_REVERSE_PROXY_AUTHENTICATION=true' \
	    -e '/^\[service\]/a ENABLE_REVERSE_PROXY_AUTO_REGISTRATION=true' \
	    -e '/^\[security\]/a REVERSE_PROXY_AUTHENTICATION_USER=Remote-User' \
	    -e '/^\[security\]/a REVERSE_PROXY_AUTHENTICATION_EMAIL=Remote-Email' \
	    .local/gitea/app.ini
