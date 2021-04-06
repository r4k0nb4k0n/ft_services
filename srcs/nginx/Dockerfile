# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/06 17:29:17 by hyechoi          ###   ########.fr        #
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
COPY conf/http.d/ /etc/nginx/http.d/
COPY html/ /var/www/html/
#RUN apk add nginx --repository=https://mirrors.ustc.edu.cn/alpine/latest-stable/community/
RUN apk add nginx --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/
EXPOSE 80 443
CMD /tmp/init.sh
