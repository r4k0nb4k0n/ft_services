# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:51:59 by hyechoi           #+#    #+#              #
#    Updated: 2021/04/06 14:40:39 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
# Run nginx in foreground.
nginx -g 'pid /tmp/nginx.pid; daemon off;'
