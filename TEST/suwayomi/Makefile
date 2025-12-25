#

include ../makefile.mk

webUI :
	sudo docker run -it --rm --user 1000:1000 \
	    --volume ./.local/tachidesk/Suwayomi-WebUI:/Suwayomi-WebUI \
	    --volume ./.local/tachidesk/webUI:/Suwayomi-WebUI/build \
	     node:22.12.0 bash

conf :
	sed -E \
	    -e 's|^(server.webUISubpath) *=.*|\1 = "/tachidesk"|' \
	    -e 's/^(server.downloadAsCbz) *=.*/\1 = true/' \
	    -e 's|^(server.downloadsPath) *=.*|\1 = "/downloads"|' \
	    -e 's/^(server.autoDownloadNewChapters) *=.*/\1 = true/' \
	    -e 's|^(server.extensionRepos) *=.*|\1 = [ "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json" ]|' \
	    -e 's/^(server.excludeUnreadChapters) *=.*/\1 = false/' \
	    -e 's|^(server.localSourcePath) *=.*|\1 = "/downloads/local"|' \
	    -i .local/tachidesk/server.conf
