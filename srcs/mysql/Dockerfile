# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/07 14:40:31 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/07 15:37:38 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
FROM alpine:3.12

# Specify the author.
MAINTAINER hyechoi@student.42seoul.kr

WORKDIR /app
COPY init.sh /tmp/init.sh
RUN apk add mysql --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/

# Create the persistent volume.
VOLUME [ "/var/lib/mysql" ]

EXPOSE 3306

ENTRYPOINT [ "/tmp/init.sh" ]
