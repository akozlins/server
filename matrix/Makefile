#

include ../makefile.mk

init ::
	mkdir -p .local/postgres

synapse_generate :
	source .env
	$(SUDO) docker run -it --rm \
	    -v ./data:/data \
	    -e SYNAPSE_SERVER_NAME="$$DOMAIN" \
	    -e SYNAPSE_REPORT_STATS=no \
	    -e UID=1000 \
	    -e GID=1000 \
	    matrixdotorg/synapse \
	    generate

synapse_register_user :
	source .env
	$(SUDO) docker run -it --rm \
	    -v ./data:/data \
	    --user 1000:1000 \
	    --entrypoint= \
	    matrixdotorg/synapse \
	    register_new_matrix_user http://127.0.0.1:8008 -c /data/homeserver.yaml

synapse_port_db :
	# https://matrix-org.github.io/synapse/latest/postgres.html
	source .env
	$(SUDO) docker run -it --rm \
	    --volume ./data:/data \
	    --user 1000:1000 \
	    --entrypoint= \
	    matrixdotorg/synapse:1.129 \
	    synapse_port_db --sqlite-database /data/homeserver.db --postgres-config /data/homeserver-postgres.yaml

matrix_login :
	source .env
	echo -n 'password: ' && read -rs PASSWORD && echo
	TOKEN=$$(curl -X POST "https://$$DOMAIN/_matrix/client/r0/login" \
	    --data-binary @- << EOF \
	    | jq -r '.access_token'
	{
	    "type" : "m.login.password",
	    "user" : "@$$MATRIX_USER:$$DOMAIN",
	    "password" : "$$PASSWORD"
	}
	EOF)
	echo TOKEN=$$TOKEN
	sed -E -e "s/^TOKEN=.*/TOKEN=$$TOKEN/" -i .env

synapse_purge_media_cache :
	BEFORE_TS="$$(date --date='1 months ago' +%s%3N)"
	curl --header "Authorization: Bearer $$TOKEN" \
	    -X POST \
	    "https://$$DOMAIN/_synapse/admin/v1/purge_media_cache?before_ts=$$BEFORE_TS"

synapse_background_updates_status :
	# https://matrix-org.github.io/synapse/latest/usage/administration/admin_api/background_updates.html
	source .env
	curl --header "Authorization: Bearer $$TOKEN" \
	    "https://$$DOMAIN/_synapse/admin/v1/background_updates/status"
