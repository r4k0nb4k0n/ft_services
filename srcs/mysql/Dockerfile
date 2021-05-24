# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/07 14:40:31 by hyechoi           #+#    #+#              #
#    Updated: 2021/05/24 12:23:40 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
# Use specific tag - alpine:3.12 to get stable.
FROM alpine:3.12
MAINTAINER hyechoi@student.42seoul.kr
# Define ARG and ENV in need.
ARG minikube_ip
ENV MINIKUBE_IP=${minikube_ip}
ARG alpine_apk_mirror_repo
ENV ALPINE_APK_MIRROR_REPO=${alpine_apk_mirror_repo}
RUN echo "${ALPINE_APK_MIRROR_REPO}/v3.12/main" > /etc/apk/repositories
RUN echo "${ALPINE_APK_MIRROR_REPO}/v3.12/community" >> /etc/apk/repositories
RUN echo "@edge ${ALPINE_APK_MIRROR_REPO}/edge/main" >> /etc/apk/repositories
RUN echo "@edgecommunity ${ALPINE_APK_MIRROR_REPO}/edge/community" >> /etc/apk/repositories
RUN apk update


WORKDIR /app

RUN apk add telegraf@edgecommunity
COPY telegraf.conf /etc/telegraf.conf

RUN apk add mysql mysql-client
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Create the persistent volume.
VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

COPY pma_create_tables.sql pma_create_tables.sql
COPY init.sh init.sh
ENTRYPOINT /bin/sh init.sh
