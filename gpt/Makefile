#

include ../makefile.mk

build :
	[ -d .local/app ] || git clone -b "master" --depth=1 https://github.com/Niek/chatgpt-web .local/app
	docker run -it --rm \
	    --user="$(id -u):$(id -g)" \
	    --volume=./.local/app:/app \
	    --workdir=/app \
	    --tmpfs="/app/node_modules:mode=777,exec" \
	    node:23 \
	    sh -c "npm ci && npm run build"
