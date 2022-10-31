#

include ../makefile.mk

init :
	mkdir -p ./.cache
	git clone https://git.tt-rss.org/fox/tt-rss ./.cache/tt-rss
	( cd .cache/tt-rss && patch -p1 < ../../tt-rss.patch )
