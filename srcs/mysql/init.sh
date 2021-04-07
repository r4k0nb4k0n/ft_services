# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/07 14:51:50 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/07 15:59:28 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

rc-service mariadb start
mysql --user=root <<_EOF_
  UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
  DELETE FROM mysql.user WHERE User='';
  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
_EOF_
mysql --user=root <<_EOF_
  CREATE DATABASE wordpress;
  CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '${MYSQL_WORDPRESSUSER_PASSWORD}';
  GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY '${MYSQL_WORDPRESSUSER_PASSWORD}' WITH GRANT OPTION;
  FLUSH PRIVILEGES;
_EOF_