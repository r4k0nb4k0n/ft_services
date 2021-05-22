#!/bin/sh

ls /tmp/flag &> /dev/null
if [ $? -eq 1 ]
then
	touch /tmp/flag
	echo "[security]" >> $GF_PATHS_CONFIG
	echo "admin_user = ${GRAFANA_ROOT_USERNAME}" >> $GF_PATHS_CONFIG
	echo "admin_password = ${GRAFANA_ROOT_PASSWORD}" >> $GF_PATHS_CONFIG
	echo "secret_key = t3st1sb3tt3rth4nth1nk" >> $GF_PATHS_CONFIG
	echo "[server]" >> $GF_PATHS_CONFIG
	echo "protocol = http" >> $GF_PATHS_CONFIG
	echo "http_port = 3000" >> $GF_PATHS_CONFIG
	echo "static_root_path = public" >> $GF_PATHS_CONFIG
	echo "root_url = http://${MINIKUBE_IP}:3000" >> $GF_PATHS_CONFIG
	echo "    user: ${INFLUXDB_FT_INFLUXDB_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-influxdb.yaml
	echo "    password: ${INFLUXDB_FT_INFLUXDB_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-influxdb.yaml
	echo "    database: ${INFLUXDB_FT_INFLUXDB_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-influxdb.yaml
	echo "    user: ${INFLUXDB_FT_GRAFANA_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-grafana.yaml
	echo "    password: ${INFLUXDB_FT_GRAFANA_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-grafana.yaml
	echo "    database: ${INFLUXDB_FT_GRAFANA_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-grafana.yaml
	echo "    user: ${INFLUXDB_FT_FTPS_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-ftps.yaml
	echo "    password: ${INFLUXDB_FT_FTPS_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-ftps.yaml
	echo "    database: ${INFLUXDB_FT_FTPS_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-ftps.yaml
	echo "    user: ${INFLUXDB_FT_MYSQL_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-mysql.yaml
	echo "    password: ${INFLUXDB_FT_MYSQL_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-mysql.yaml
	echo "    database: ${INFLUXDB_FT_MYSQL_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-mysql.yaml
	echo "    user: ${INFLUXDB_FT_WORDPRESS_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-wordpress.yaml
	echo "    password: ${INFLUXDB_FT_WORDPRESS_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-wordpress.yaml
	echo "    database: ${INFLUXDB_FT_WORDPRESS_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-wordpress.yaml
	echo "    user: ${INFLUXDB_FT_PHPMYADMIN_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-phpmyadmin.yaml
	echo "    password: ${INFLUXDB_FT_PHPMYADMIN_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-phpmyadmin.yaml
	echo "    database: ${INFLUXDB_FT_PHPMYADMIN_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-phpmyadmin.yaml
	echo "    user: ${INFLUXDB_FT_NGINX_USERNAME}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-nginx.yaml
	echo "    password: ${INFLUXDB_FT_NGINX_PASSWORD}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-nginx.yaml
	echo "    database: ${INFLUXDB_FT_NGINX_DATABASE}" >> $GF_PATHS_HOME/conf/provisioning/datasources/ft-nginx.yaml
fi

grafana-server						\
	--homepath="$GF_PATHS_HOME"		\
	--config="$GF_PATHS_CONFIG"		\
	--packaging=docker
