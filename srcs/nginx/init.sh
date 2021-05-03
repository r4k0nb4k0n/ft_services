#!/bin/sh
# Run nginx in foreground.
nginx -g 'pid /tmp/nginx.pid; daemon off;'
