# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/07 14:40:31 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/27 21:28:54 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
# Use specific tag - alpine:3.12 to get stable.
FROM alpine:3.12
MAINTAINER hyechoi@student.42seoul.kr
# Define ARG and ENV in need.
ARG minikube_ip
ENV MINIKUBE_IP=${minikube_ip}

WORKDIR /app

RUN apk add mysql mysql-client --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Create the persistent volume.
VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

COPY init.sh init.sh
ENTRYPOINT /bin/sh init.sh
