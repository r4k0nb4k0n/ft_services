#!/bin/zsh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 13:16:14 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/05 13:27:18 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Welcome!

echo "\n$(tput setaf 7; tput setab 5; tput bold)# ************************ #$(tput sgr 0)"
echo "$(tput setaf 7; tput setab 5; tput bold)#  ft_services by hyechoi  #$(tput sgr 0)"
echo "$(tput setaf 7; tput setab 5; tput bold)# ************************ #$(tput sgr 0)\n"

# Check dependencies.

echo "$(tput setaf 7; tput setab 4; tput bold)___Check dependencies.___$(tput sgr 0)\n"

## Check if docker is available.

echo "$(tput setaf 7; tput setab 2; tput bold)___Check if Docker is available.___$(tput sgr 0)"
which docker
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)Docker is unavailable.$(tput sgr 0)\n"
	exit $?
fi
pgrep -x Docker
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)Docker for Mac is not running. Run 'open -g -a Docker'.$(tput sgr 0)\n"
	exit $?
fi

## Check if virtualbox is available.

echo "$(tput setaf 7; tput setab 2; tput bold)___Check if VirtualBox is available.___$(tput sgr 0)"
which virtualbox
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)VirtualBox is unavailable.$(tput sgr 0)\n"
	exit $?
fi

## Check if minikube is available.

echo "$(tput setaf 7; tput setab 2; tput bold)___Check if Minikube is available.___$(tput sgr 0)"
which minikube
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)Minikube is unavailable.$(tput sgr 0)\n"
	exit $?
fi

# minikube delte before minikube start.
echo "\n$(tput setaf 7; tput setab 4; tput bold)___Delete minikube setup before start.___$(tput sgr 0)"
minikube delete
minikube delete --all

# Run minikube.
echo "\n$(tput setaf 7; tput setab 4; tput bold)___Run minikube start with VirtualBox vm driver.___$(tput sgr 0)"
export MINIKUBE_HOME=~/goinfre
echo "\n$(tput setaf 7; tput setab 2; tput bold)___Set minikube config memory.___$(tput sgr 0)"
minikube config set memory 4096
echo "\n$(tput setaf 7; tput setab 2; tput bold)___Set minikube config disk-size.___$(tput sgr 0)"
minikube config set disk-size 6120
minikube start --wait=false --vm-driver=virtualbox
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)Can't 'minikube start'.$(tput sgr 0)\n"
	exit $?
fi

# Install metallb.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Install metallb.___$(tput sgr 0)"
minikube addons enable metallb
MINIKUBE_IP=$(minikube ip)
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/metallb/manifests/configmap.yaml > ./configmap_sed.yaml
kubectl apply -f ./configmap_sed.yaml
rm -f ./configmap_sed.yaml

# Link minikube to local docker.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Link minikube to local docker.___$(tput sgr 0)"
eval $(minikube docker-env)

# Build container images in need.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Build container images in need.___$(tput sgr 0)"
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-influxdb.___$(tput sgr 0)"
docker build ./srcs/influxdb/ -t alpine:ft-influxdb --build-arg minikube_ip=$MINIKUBE_IP
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-grafana.___$(tput sgr 0)"
docker build ./srcs/grafana/ -t alpine:ft-grafana --build-arg minikube_ip=$MINIKUBE_IP
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-nginx.___$(tput sgr 0)"
docker build ./srcs/nginx/ -t alpine:ft-nginx --build-arg minikube_ip=$MINIKUBE_IP
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-mysql.___$(tput sgr 0)"
docker build ./srcs/mysql/ -t alpine:ft-mysql
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-phpmyadmin.___$(tput sgr 0)"
docker build ./srcs/phpmyadmin/ -t alpine:ft-phpmyadmin
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-wordpress.___$(tput sgr 0)"
docker build ./srcs/wordpress/ -t alpine:ft-wordpress --build-arg minikube_ip=$MINIKUBE_IP
echo "$(tput setaf 7; tput setab 2; tput bold)___Build ft-ftps.___$(tput sgr 0)"
docker build ./srcs/ftps/ -t alpine:ft-ftps --build-arg minikube_ip=$MINIKUBE_IP

# Apply container images to kube.
 
echo "\n$(tput setaf 7; tput setab 4; tput bold)___Apply container images to kube.___$(tput sgr 0)"
kubectl apply -f ./srcs/secrets.yaml
kubectl apply -f ./srcs/influxdb/manifest.yaml
kubectl apply -f ./srcs/grafana/manifest.yaml
kubectl apply -f ./srcs/mysql/manifest.yaml
kubectl apply -f ./srcs/nginx/manifest.yaml
kubectl apply -f ./srcs/phpmyadmin/manifest.yaml
kubectl apply -f ./srcs/ftps/manifest.yaml
kubectl apply -f ./srcs/wordpress/manifest.yaml

# Enable dashboard, metrics-server.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Enable dashboard, metrics-server.___$(tput sgr 0)"
minikube addons enable dashboard
minikube addons enable metrics-server

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Run dashboard on background.___$(tput sgr 0)"
minikube dashboard &
