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
