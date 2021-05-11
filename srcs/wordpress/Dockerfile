# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/07 18:10:36 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
#FROM alpine:latest
FROM alpine:3.12

# Specify the author.
MAINTAINER hyechoi@student.42seoul.kr

WORKDIR /app
COPY init.sh /tmp/init.sh
COPY ssl/ /etc/nginx/ssl/
COPY conf/conf.d/ /etc/nginx/conf.d/
COPY wordpress.tar.gz /tmp/
RUN apk add nginx --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/
RUN tar -xvf /tmp/wordpress.tar.gz -C /var/www/
COPY wp-config.php /var/www/wordpress/
RUN apk add php7 php7-fpm php7-common php7-mbstring php7-soap php7-gd php7-xml php7-intl php7-mysqli php7-cli php7-zip php7-curl php7-iconv php7-json php7-session --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/
RUN echo "env[MYSQL_WORDPRESSUSER_PASSWORD]=\$MYSQL_WORDPRESSUSER_PASSWORD" >> /etc/php7/php-fpm.d/www.conf

EXPOSE 5050
CMD /tmp/init.sh
