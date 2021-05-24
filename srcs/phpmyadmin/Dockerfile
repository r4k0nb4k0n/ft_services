# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/05/24 12:24:18 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
#FROM alpine:latest
FROM alpine:3.12

# Specify the author.
MAINTAINER hyechoi@student.42seoul.kr

ARG alpine_apk_mirror_repo
ENV ALPINE_APK_MIRROR_REPO=${alpine_apk_mirror_repo}
RUN echo "${ALPINE_APK_MIRROR_REPO}/v3.12/main" > /etc/apk/repositories
RUN echo "${ALPINE_APK_MIRROR_REPO}/v3.12/community" >> /etc/apk/repositories
RUN echo "@edge ${ALPINE_APK_MIRROR_REPO}/edge/main" >> /etc/apk/repositories
RUN echo "@edgecommunity ${ALPINE_APK_MIRROR_REPO}/edge/community" >> /etc/apk/repositories
RUN apk update

RUN apk add telegraf@edgecommunity
COPY telegraf.conf /etc/telegraf.conf

WORKDIR /app
COPY init.sh init.sh
COPY ssl/ /etc/nginx/ssl/
COPY conf/conf.d/ /etc/nginx/conf.d/
COPY phpMyAdmin.zip phpMyAdmin.zip
RUN apk add nginx
RUN unzip /app/phpMyAdmin.zip -d /var/www/
RUN mv /var/www/phpMyAdmin* /var/www/html
COPY config.inc.php /var/www/html/
RUN apk add php7 php7-fpm php7-common php7-mbstring php7-soap php7-gd php7-xml php7-intl php7-mysqli php7-cli php7-zip php7-curl php7-iconv php7-json php7-session

EXPOSE 5000
CMD /bin/sh /app/init.sh
