#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

#change user pass
if [ -z "$ROOT_PASS" ]; then
	export ROOT_PASS="root"
	echo "Set root pass to root"
    echo "root:root"|chpasswd
else
	echo "root:$ROOT_PASS" | chpasswd
fi

echo "Run supervisord"

/usr/bin/supervisord -n -c /etc/supervisord.conf