#

include ../makefile.mk

init ::
	mkdir -p .local
	[ -f .local/admin_password.key ] || pwgen -s 16 > .local/admin_password.key
