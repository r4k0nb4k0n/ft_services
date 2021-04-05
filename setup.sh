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

## Check if minikube is available.

echo "$(tput setaf 7; tput setab 2; tput bold)___Check if Minikube is available.___$(tput sgr 0)"
which minikube
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)Minikube is unavailable.$(tput sgr 0)\n"
	exit $?
fi

# Run minikube.
echo "\n$(tput setaf 7; tput setab 4; tput bold)___Run minikube start.___$(tput sgr 0)"
minikube start
if [[ "$?" != "0" ]]; then
	echo "$(tput setaf 7; tput setab 1; tput bold)Can't 'minikube start'. Is Docker running?$(tput sgr 0)\n"
	exit $?
fi

# Install metallb.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Install metallb.___$(tput sgr 0)"
minikube addons enable metallb
kubectl apply -f ./srcs/metallb/manifests/configmap.yaml
#kubectl apply -f ./srcs/metallb/manifests/namespace.yaml
#kubectl apply -f ./srcs/metallb/manifests/metallb.yaml
#kubectl delete secret -n metallb-system memberlist
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
#kubectl delete configmap -n metallb-system config
#MINIKUBE_IP=$(minikube ip)
#sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/metallb/manifests/configmap.yaml > ./configmap_sed.yaml
#kubectl create -f ./configmap_sed.yaml
#rm -f ./configmap_sed.yaml

# Link minikube to local docker.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Link minikube to local docker.___$(tput sgr 0)"
eval $(minikube docker-env)

# Build nginx image and run.



# Enable dashboard, metrics-server.

echo "\n$(tput setaf 7; tput setab 4; tput bold)___Enable dashboard, metrics-server.___$(tput sgr 0)"
minikube addons enable dashboard
minikube addons enable metrics-server
