#

include ../makefile.mk

init ::
	mkdir -p .local && cd .local || exit 1
	if [ ! -d tt-rss/.git ] ; then
	    git clone https://git.tt-rss.org/fox/tt-rss
	    patch --directory=tt-rss -p1 < ../tt-rss.patch
	fi
