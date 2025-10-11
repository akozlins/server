#

include ../makefile.mk

webUI :
	sudo docker run -it --rm --user 1000:1000 \
	    --volume ./.local/tachidesk/Suwayomi-WebUI:/Suwayomi-WebUI \
	    --volume ./.local/tachidesk/webUI:/Suwayomi-WebUI/build \
	     node:22.12.0 bash
