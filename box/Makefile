#

include ../makefile.mk

init ::
	mkdir -p -- .local && cd .local || exit 1
	# qbittorrent
	mkdir -p qbittorrent/logs
	[ -L qbittorrent/logs/qbittorrent.log ] || ln -s -T /dev/stdout qbittorrent/logs/qbittorrent.log
	[ -f qbittorrent/qBittorrent.conf ] || cat ../qBittorrent.conf | envsubst > qbittorrent/qBittorrent.conf
	# jackett, sonarr, sabnzbd
	mkdir -p jackett sonarr sabnzbd
