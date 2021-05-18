#!/bin/sh

ls /var/www/wordpress/flag &>/dev/null
if [ $? -eq 1 ]
then
	cd /var/www/wordpress
	touch flag
	# Create wp-config.php
	while [ 1 ]
	do
		wp config create --dbhost=ft-mysql --dbname=wordpress --dbuser=wordpressuser --dbpass=$MYSQL_WORDPRESSUSER_PASSWORD --locale=ko_KR
		sleep 1
		if [ $? -eq 0 ]
		then
			break
		fi
	done
	# Create DB based on wp-config.php
	wp db create
	# Install core with given info
	wp core install --url=${MINIKUBE_IP}:5050 --title=ft_services-wordpress --admin_user=${FT_WORDPRESS_ADMIN_USERNAME} --admin_password=${FT_WORDPRESS_ADMIN_PASSWORD} --admin_email=hyechoi@student.42seoul.kr
	# Add several users.
	wp user create ${FT_WORDPRESS_USER_ALICE_USERNAME} ${FT_WORDPRESS_USER_ALICE_EMAIL} --display_name=${FT_WORDPRESS_USER_ALICE_DISPLAY_NAME} --user_pass=${FT_WORDPRESS_USER_ALICE_PASSWORD}
	wp user create ${FT_WORDPRESS_USER_BOB_USERNAME} ${FT_WORDPRESS_USER_BOB_EMAIL} --display_name=${FT_WORDPRESS_USER_BOB_DISPLAY_NAME} --user_pass=${FT_WORDPRESS_USER_BOB_PASSWORD}
	wp user create ${FT_WORDPRESS_USER_MARY_USERNAME} ${FT_WORDPRESS_USER_MARY_EMAIL} --display_name=${FT_WORDPRESS_USER_MARY_DISPLAY_NAME} --user_pass=${FT_WORDPRESS_USER_MARY_PASSWORD}
fi

php-fpm7
# Run nginx in foreground.
nginx -g 'pid /tmp/nginx.pid; daemon off;'
