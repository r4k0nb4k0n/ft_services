#!/bin/sh

telegraf --config /etc/telegraf.conf 1>/dev/null 2>&1 &

ls /var/www/html/flag &>/dev/null
if [ $? -eq 1 ]
then
	# Set pma control password in config.inc.php.
	echo "\$cfg['Servers'][\$i]['controlpass'] = '${MYSQL_PMA_PASSWORD}';" >> /var/www/html/config.inc.php
	touch /var/www/html/flag
fi
php-fpm7
mkdir /tmp/pma_cache/
chmod 777 /tmp/pma_cache/
# Run nginx in foreground.
nginx -g 'pid /tmp/nginx.pid; daemon off;'
