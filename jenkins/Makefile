#

include ../makefile.mk

init ::
	mkdir -p -- .cache && cd .cache
	# generate ssh key
	mkdir -p -- node/.ssh
	[ -f node/.ssh/id_node ] || ssh-keygen -t ed25519 -f node/.ssh/id_node -C "" -N ""
	#cp node/.ssh/id_node.pub node/.ssh/authorized_keys
	chmod -R go-rwx node/.ssh
