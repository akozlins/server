#

include ../makefile.mk

init ::
	mkdir -p -- .local
	cd .local || exit 1
	mkdir -p -- data/{downloads,incomplete,media}
	# qbittorrent
	mkdir -p qbittorrent/data/logs
	[ -L qbittorrent/data/logs/qbittorrent.log ] || ln -s -T /dev/stdout qbittorrent/data/logs/qbittorrent.log
	[ -f qbittorrent/config/qBittorrent.conf ] || cat ../qBittorrent.conf | envsubst > qbittorrent/config/qBittorrent.conf
	# jackett, sonarr, mylar, sabnzbd
	mkdir -p -- jackett sonarr mylar sabnzbd
