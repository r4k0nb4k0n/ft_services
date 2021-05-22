# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/05/22 23:48:23 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
# Use specific tag - alpine:3.12 to get stable.
FROM alpine:3.12
MAINTAINER hyechoi@student.42seoul.kr
# Define ARG and ENV in need.
ARG minikube_ip
ENV MINIKUBE_IP=${minikube_ip}

RUN apk add telegraf --repository http://alpine.42.fr/edge/community/
COPY telegraf.conf /etc/telegraf.conf

# Install nginx and openssl.
# openssl is needed for generating SSL private key and certificate.
RUN apk add nginx openssl

WORKDIR /app

# Generate SSL private key and certificate with CN=$MINIKUBE_IP.
COPY gen_ssl.sh gen_ssl.sh
RUN /bin/sh gen_ssl.sh

# Copy nginx configuration file.
COPY conf/conf.d/ /etc/nginx/conf.d/
# Copy contents for serving.
COPY html/ /var/www/html/
# Expose port for HTTP and HTTPS.
EXPOSE 80 443

COPY init.sh init.sh
ENTRYPOINT /bin/sh init.sh
