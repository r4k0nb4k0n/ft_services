#!/bin/bash

kubectl exec deploy/ft-mysql -- pkill mysqld
kubectl exec deploy/ft-nginx -- pkill nginx
kubectl exec deploy/ft-influxdb -- pkill influxd
kubectl exec deploy/ft-grafana -- pkill grafana
kubectl exec deploy/ft-ftps -- pkill vsftpd
kubectl exec deploy/ft-phpmyadmin -- pkill nginx
kubectl exec deploy/ft-wordpress -- pkill nginx
