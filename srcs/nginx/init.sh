#!/bin/sh

telegraf --config /etc/telegraf.conf 1>/dev/null 2>&1 &

nginx -g 'pid /tmp/nginx.pid; daemon off;'
tail -f /var/log/nginx/access.log
