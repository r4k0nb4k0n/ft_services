#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
fi

mysql_install_db --user=root --datadir=/var/lib/mysql

/usr/bin/mysqld_safe --user=root --console & sleep 3

ls /var/lib/mysql/flag &>/dev/null
if [ $? -eq 1 ]
then
	touch /var/lib/mysql/flag
	# Exec init query with mysql-client.
	mysql --user=root <<EOF
	  ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	  CREATE USER 'root'@'172.17.0.1' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	  GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.17.0.1';
	  DROP DATABASE IF EXISTS test;
	  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	  CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '$MYSQL_WORDPRESSUSER_PASSWORD';
	  CREATE USER 'wordpressuser'@'172.17.0.1' IDENTIFIED BY '$MYSQL_WORDPRESSUSER_PASSWORD';
	  GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY '$MYSQL_WORDPRESSUSER_PASSWORD';
	  GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'172.17.0.1' IDENTIFIED BY '$MYSQL_WORDPRESSUSER_PASSWORD';
	  CREATE user 'pma'@'localhost' IDENTIFIED BY '$MYSQL_PMA_PASSWORD';
	  CREATE user 'pma'@'172.17.0.1' IDENTIFIED BY '$MYSQL_PMA_PASSWORD';
	  FLUSH PRIVILEGES;
EOF
	mysql --user=root -p$MYSQL_ROOT_PASSWORD < /app/pma_create_tables.sql
fi

tail -f /dev/null
