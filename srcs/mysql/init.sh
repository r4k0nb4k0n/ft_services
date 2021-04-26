#!/bin/sh

if [ ! -d /run/mysqld ]; then
	mkdir -p /run/mysqld
fi

mysql_install_db --user=root --ldata=/var/lib/mysql > /dev/null

/usr/bin/mysqld --user=root --bootstrap <<_EOF_
  USE mysql;
  FLUSH PRIVILEGES;
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
  DROP USER '';
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
  CREATE DATABASE wordpress;
  CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '${MYSQL_WORDPRESSUSER_PASSWORD}';
  GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY '${MYSQL_WORDPRESSUSER_PASSWORD}' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
_EOF_

exec /usr/bin/mysqld --user=root --console
