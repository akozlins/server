#

include ../makefile.mk

init ::
	mkdir -p .local && cd .local || exit 1
	if [ ! -d FreshRSS/.git ] ; then
	    git clone https://github.com/FreshRSS/FreshRSS
	fi
	[ -L html/fresh ] || ( mkdir -p html && ln -s -T ../FreshRSS/p html/fresh )
