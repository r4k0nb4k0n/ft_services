# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hyechoi <hyechoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/05 17:45:21 by hyechoi           #+#    #+#              #
#    Updated: 2021/05/24 12:22:26 by hyechoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# The containers have to be build using Alpine Linux.
# Use specific tag - alpine:3.12 to get stable.
FROM alpine:3.12
MAINTAINER hyechoi@student.42seoul.kr
# Define ARG and ENV in need.
ARG minikube_ip
ENV MINIKUBE_IP=${minikube_ip}
ARG alpine_apk_mirror_repo
ENV ALPINE_APK_MIRROR_REPO=${alpine_apk_mirror_repo}
RUN echo "${ALPINE_APK_MIRROR_REPO}/v3.12/main" > /etc/apk/repositories
RUN echo "${ALPINE_APK_MIRROR_REPO}/v3.12/community" >> /etc/apk/repositories
RUN echo "@edge ${ALPINE_APK_MIRROR_REPO}/edge/main" >> /etc/apk/repositories
RUN echo "@edgecommunity ${ALPINE_APK_MIRROR_REPO}/edge/community" >> /etc/apk/repositories
RUN apk update

ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GF_PATHS_CONFIG="/etc/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/usr/share/grafana/conf/provisioning"

RUN apk add telegraf@edgecommunity
COPY telegraf.conf /etc/telegraf.conf

RUN apk add grafana@edgecommunity

WORKDIR /app

COPY grafana.ini "$GF_PATHS_CONFIG"
COPY conf/ $GF_PATHS_HOME/conf/

# Expose port for grafana.
EXPOSE 3000

COPY init.sh init.sh
ENTRYPOINT /bin/sh init.sh
