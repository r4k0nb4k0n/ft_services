#!/bin/sh
nginx -g 'pid /tmp/nginx.pid; daemon off;'
tail -f /var/log/nginx/access.log
