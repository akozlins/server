#

include ../makefile.mk

init ::
	mkdir -p .local/data
	[ -f .local/data/admin_password.key ] || pwgen -s 16 > .local/data/admin_password.key
