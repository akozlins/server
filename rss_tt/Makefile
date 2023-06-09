#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -z "$${ROUTE:+x}" ] && echo "ROUTE=tt" >> .env
	[ -z "$${DB_PASSWORD:+x}" ] && echo "DB_PASSWORD=$$(cat /proc/sys/kernel/random/uuid)" >> .env
	[ -z "$${DB_USER:+x}" ] && echo "DB_UESR=db_user" >> .env
	
	source .env
	mkdir -p .local && cd .local || exit 1
	if [ ! -d tt-rss/.git ] ; then
	    git clone https://git.tt-rss.org/fox/tt-rss
	    patch --directory=tt-rss -p1 < ../tt-rss.patch
	fi
	[ -L "html/$$ROUTE" ] || ( mkdir -p html && ln -s -T ../tt-rss "html/$$ROUTE" )
