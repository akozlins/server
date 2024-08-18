#

include ../makefile.mk

init ::
	mkdir -p -- .local/gitea
	# <https://docs.gitea.com/next/administration/config-cheat-sheet>
	#sed '/\[service\]/a ENABLE_REVERSE_PROXY_AUTHENTICATION=true' .local/gitea/gitea/conf/app.ini
	#sed '/\[service\]/a ENABLE_REVERSE_PROXY_AUTO_REGISTRATION=true' .local/gitea/gitea/conf/app.ini
	#sed '/\[security\]/a REVERSE_PROXY_TRUSTED_PROXIES=$(TRAEFIK_SUBNET)' .local/gitea/gitea/conf/app.ini
	#sed '/\[security\]/a REVERSE_PROXY_AUTHENTICATION_USER=Remote-User' .local/gitea/gitea/conf/app.ini
	#sed '/\[security\]/a REVERSE_PROXY_AUTHENTICATION_EMAIL=Remote-Email' .local/gitea/gitea/conf/app.ini
	
	mkdir -p -- .local/gerrit/{db,etc,git,cache,index}
	#git config --file .local/gerrit/etc/gerrit.config auth.type HTTP
	#git config --file .local/gerrit/etc/gerrit.config auth.httpHeader Remote-Name
	#git config --file .local/gerrit/etc/gerrit.config auth.emailFormat '{0}@$DOMAIN'
