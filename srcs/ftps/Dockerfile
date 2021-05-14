# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/12 14:40:56 by hyechoi           #+#    #+#              #
#    Updated: 2021/05/14 22:30:10 by hyechoi          ###   ########.fr        #
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
RUN apk add vsftpd openssl --repository=https://mirrors.ustc.edu.cn/alpine/v3.12/community/

WORKDIR /app

# Generate SSL private key and certificate with CN=$MINIKUBE_IP.
COPY gen_ssl.sh gen_ssl.sh
RUN /bin/sh gen_ssl.sh

# Set up configuration file.
COPY vsftpd.conf /etc/vsftpd.conf
RUN echo "pasv_address=${MINIKUBE_IP}" >> /etc/vsftpd.conf

# Add ftpuser and set password.
COPY ftpuser.sh ftpuser.sh
RUN /bin/sh ftpuser.sh

# Expose port for FTP ports.
EXPOSE 20 21 30020 30021

COPY init.sh init.sh
ENTRYPOINT /bin/sh init.sh
