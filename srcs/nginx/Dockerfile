# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/05 17:58:42 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
FROM alpine:latest

# Specify the author.
MAINTAINER hyechoi@student.42seoul.kr

WORKDIR /app
COPY init.sh /tmp/init.sh
RUN apk add nginx --repository=https://mirrors.ustc.edu.cn/alpine/latest-stable/community/
EXPOSE 80 443
RUN bash /tmp/init.sh
