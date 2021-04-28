#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

mysql_install_db --user=root --datadir=/var/lib/mysql

/usr/bin/mysqld --user=root --console & sleep 3

ls /var/lib/mysql/flag
if [ $? -eq 1 ]
then
	touch /var/lib/mysql/flag
	# Exec init query with mysql-client.
	mysql --user=root <<EOF
	  USE mysql;
	  FLUSH PRIVILEGES;
	  ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	  CREATE USER 'root'@'172.17.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	  DROP DATABASE IF EXISTS test;
	  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	  FLUSH PRIVILEGES;
	  CREATE DATABASE wordpress;
	  CREATE USER 'wordpressuser'@'172.17.0.1' IDENTIFIED BY '$MYSQL_WORDPRESSUSER_PASSWORD';
	  GRANT ALL ON wordpress.* TO 'wordpressuser'@'172.17.0.1' IDENTIFIED BY '$MYSQL_WORDPRESSUSER_PASSWORD' WITH GRANT OPTION;
	  FLUSH PRIVILEGES;
EOF
fi

tail -f /dev/null
