# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:51:59 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/28 16:30:58 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh
php-fpm7
mkdir /tmp/pma_cache/
chmod 777 /tmp/pma_cache/
# Run nginx in foreground.
nginx -g 'pid /tmp/nginx.pid; daemon off;'
