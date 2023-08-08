#

include ../makefile.mk

init ::
	mkdir -p -- .local/qbittorrent/logs && cd .local || exit 1
	[ -L qbittorrent/logs/qbittorrent.log ] || ln -s -T /dev/stdout qbittorrent/logs/qbittorrent.log
