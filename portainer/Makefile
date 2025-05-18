#

include ../makefile.mk

init ::
	# init files
	mkdir -p .local && cd .local || exit 1
	[ -f admin_password.key ] || echo "$$(pwgen -s 16 1)" > admin_password.key
