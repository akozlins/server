#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -n "$${ROUTE:+x}" ] || echo "ROUTE=fresh" >> .env
	
	source .env
	mkdir -p .local && cd .local || exit 1
	if [ ! -d FreshRSS/.git ] ; then
	    git clone https://github.com/FreshRSS/FreshRSS
	fi
	[ -L "html/$$ROUTE" ] || ( mkdir -p html && ln -s -T ../FreshRSS/p "html/$$ROUTE" )
