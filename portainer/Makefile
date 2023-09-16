#

include ../makefile.mk

init ::
	# init files
	mkdir -p .local && cd .local || exit 1
	[ -f admin_password.key ] || echo "$$(pwgen -s 16 1)" > admin_password.key

backup :
	docker run --rm \
	    -v portainer_data:/data \
	    -v ./.local:/.local \
	    debian \
	    sh -c "tar -cf /.local/data.tar --directory /data . && chown 1000:1000 /.local/data.tar"

restore :
	docker run --rm \
	    -v portainer_data:/data \
	    -v ./.local:/.local \
	    debian \
	    sh -c "tar -xf /.local/data.tar --directory /data"
