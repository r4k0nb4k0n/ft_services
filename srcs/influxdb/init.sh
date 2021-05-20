#!/bin/sh

ls /var/lib/influxdb/flag &>/dev/null
if [ $? -eq 1 ]
then
	touch /var/lib/influxdb/flag
	# Start influxd run.
	influxd run -pidfile /app/influxd.pidfile -config /app/influxdb.auth-disabled.conf & sleep 3
	# Create users in need.
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_ROOT_USERNAME} WITH PASSWORD '${INFLUXDB_ROOT_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_NGINX_USERNAME} WITH PASSWORD '${INFLUXDB_FT_NGINX_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_PHPMYADMIN_USERNAME} WITH PASSWORD '${INFLUXDB_FT_PHPMYADMIN_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_WORDPRESS_USERNAME} WITH PASSWORD '${INFLUXDB_FT_WORDPRESS_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_MYSQL_USERNAME} WITH PASSWORD '${INFLUXDB_FT_MYSQL_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_FTPS_USERNAME} WITH PASSWORD '${INFLUXDB_FT_FTPS_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_GRAFANA_USERNAME} WITH PASSWORD '${INFLUXDB_FT_GRAFANA_PASSWORD}'"
	influx -host 'localhost' -port '8086' -execute "CREATE USER ${INFLUXDB_FT_INFLUXDB_USERNAME} WITH PASSWORD '${INFLUXDB_FT_INFLUXDB_PASSWORD}'"
	# Create databases(buckets) in need.
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_NGINX_DATABASE}"
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_PHPMYADMIN_DATABASE}"
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_WORDPRESS_DATABASE}"
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_MYSQL_DATABASE}"
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_FTPS_DATABASE}"
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_GRAFANA_DATABASE}"
	influx -host 'localhost' -port '8086' -execute "CREATE DATABASE ${INFLUXDB_FT_INFLUXDB_DATABASE}"
	# Grant several privileges to users in need.
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_NGINX_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_PHPMYADMIN_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_WORDPRESS_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_MYSQL_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_FTPS_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_GRAFANA_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT ALL ON ${INFLUXDB_FT_INFLUXDB_DATABASE} TO ${INFLUXDB_ROOT_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_NGINX_DATABASE} TO ${INFLUXDB_FT_NGINX_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_PHPMYADMIN_DATABASE} TO ${INFLUXDB_FT_PHPMYADMIN_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_WORDPRESS_DATABASE} TO ${INFLUXDB_FT_WORDPRESS_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_MYSQL_DATABASE} TO ${INFLUXDB_FT_MYSQL_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_FTPS_DATABASE} TO ${INFLUXDB_FT_FTPS_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_GRAFANA_DATABASE} TO ${INFLUXDB_FT_GRAFANA_USERNAME}"
	influx -host 'localhost' -port '8086' -execute "GRANT WRITE ON ${INFLUXDB_FT_INFLUXDB_DATABASE} TO ${INFLUXDB_FT_INFLUXDB_USERNAME}"
	# Give permission to users.
	# Kill influxd for restarting.
	kill -9 `cat /app/influxd.pidfile`
fi

influxd run -pidfile /app/influxd.pidfile -config /app/influxdb.auth-enabled.conf  & sleep 3
tail -f /dev/null
