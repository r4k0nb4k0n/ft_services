#!/bin/sh
mkdir /etc/nginx/ssl
cd /etc/nginx/ssl
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Gun/emailAddress=hyechoi@student.42seoul.kr/CN=${MINIKUBE_IP}" -keyout ft-nginx.key -out ft-nginx.crt
