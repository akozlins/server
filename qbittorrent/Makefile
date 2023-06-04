#

include ../makefile.mk

init ::
	mkdir -p -- .local/logs && cd .local || exit 1
	[ -L logs/qbittorrent.log ] || ln -s -T /dev/stdout logs/qbittorrent.log
