#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -n "$${V2RAY_ID:+x}" ] || echo "V2RAY_ID=$$(cat /proc/sys/kernel/random/uuid)" >> .env
