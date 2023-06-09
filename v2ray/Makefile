#

include ../makefile.mk

init ::
	[ -f .env ] && source .env
	[ -z "$${V2RAY_ADDRESS:+x}" ] && echo "V2RAY_ADDRESS=127.0.0.1" >> .env
	[ -z "$${V2RAY_ID:+x}" ] && echo "V2RAY_ID=$$(cat /proc/sys/kernel/random/uuid)" >> .env
