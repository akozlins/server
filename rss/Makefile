#

include ../makefile.mk

init ::
	# init envs
	[ -f .env ] && source .env
	[ -n "$${DB_PASSWORD:+x}" ] || echo "DB_PASSWORD=$$(pwgen -s 16 1)" >> .env
	[ -n "$${DB_USER:+x}" ] || echo "DB_USER=db_user" >> .env
	# init files
	source .env
	mkdir -p .local/postgres && cd .local || exit 1
	# tt rss
	if [ ! -d tt/.git ] ; then
	    git clone https://github.com/tt-rss/tt-rss
	fi
	[ -L "html/tt" ] || ( mkdir -p html && ln -s -T ../tt "html/tt" )
	# fresh rss
	if [ ! -d fresh/.git ] ; then
	    git clone https://github.com/FreshRSS/FreshRSS fresh
	fi
	[ -L "html/fresh" ] || ( mkdir -p html && ln -s -T ../fresh/p "html/fresh" )
