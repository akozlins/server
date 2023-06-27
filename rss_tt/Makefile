#

include ../makefile.mk

init ::
	# init envs
	[ -f .env ] && source .env
	[ -n "$${ROUTE:+x}" ] || echo "ROUTE=tt" >> .env
	[ -n "$${DB_PASSWORD:+x}" ] || echo "DB_PASSWORD=$$(pwgen -s 16 1)" >> .env
	[ -n "$${DB_USER:+x}" ] || echo "DB_USER=db_user" >> .env
	# init files
	source .env
	mkdir -p .local && cd .local || exit 1
	if [ ! -d tt-rss/.git ] ; then
	    git clone https://git.tt-rss.org/fox/tt-rss
	    patch --directory=tt-rss -p1 < ../tt-rss.patch
	fi
	[ -L "html/$$ROUTE" ] || ( mkdir -p html && ln -s -T ../tt-rss "html/$$ROUTE" )
