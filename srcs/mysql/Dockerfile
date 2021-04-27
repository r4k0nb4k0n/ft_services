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
FROM alpine:3.12

# Specify the author.
MAINTAINER hyechoi@student.42seoul.kr

WORKDIR /app
COPY init.sh /tmp/init.sh
RUN apk add mysql mysql-client --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/
COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Create the persistent volume.
VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

ENTRYPOINT [ "/tmp/init.sh" ]
