#

include ../makefile.mk

build :
	[ -d .local/app ] || git clone -b "v10.19.4" --depth=1 https://github.com/gchq/CyberChef.git .local/app
	docker run -it --rm \
	    --user="$(id -u):$(id -g)" \
	    --volume=./.local/app:/app \
	    --workdir=/app \
	    --tmpfs="/app/node_modules:mode=777,exec" \
	    --env="NODE_OPTIONS=--max_old_space_size=2048" \
	    node:21 \
	    sh -c "npm ci && npm run build"
