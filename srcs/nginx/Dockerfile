# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/05/06 08:30:48 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
# Use specific tag - alpine:3.12 to get stable.
FROM alpine:3.12
MAINTAINER hyechoi@student.42seoul.kr
# Define ARG and ENV in need.
ARG minikube_ip
ENV MINIKUBE_IP=${minikube_ip}

# Install nginx and openssl.
# openssl is needed for generating SSL private key and certificate.
RUN apk add nginx openssl --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/

COPY . /app
WORKDIR /app

# Generate SSL private key and certificate with CN=$MINIKUBE_IP.
RUN /bin/sh gen_ssl.sh

# Copy nginx configuration file.
RUN cp -R conf/conf.d/ /etc/nginx/conf.d/
# Copy contents for serving.
RUN cp -R html/ /var/www/html/
# Expose port for HTTP and HTTPS.
EXPOSE 80 443

ENTRYPOINT /bin/sh init.sh
