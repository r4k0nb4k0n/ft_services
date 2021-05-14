#!/bin/sh
mkdir /etc/vsftpd/ssl
cd /etc/vsftpd/ssl
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gun/emailAddress=hyechoi@student.42seoul.kr/CN=${MINIKUBE_IP}" -keyout ft-ftps.key -out ft-ftps.crt
