# ft_services
This is a System Administration and Networking project from 42.

## How to setup and run

```sh
sh setup.sh
```

## Architecture

![image](https://user-images.githubusercontent.com/5409746/135629963-9036c1fc-f38f-4119-9c19-f8a31c0032eb.png)

## Description

- Kubernetes Web Dashboard.
- MetalLB as a Load Balancer. It has only one IP and is the only entry point to the cluster.
- A WordPress website listening on port 5050, which will work with a MySQL database.
Both services have to run in separate containers. The WordPress website will have several users and an administrator. Wordpress needs its own nginx server. The Load Balancer should be able to redirect directly to this service.
- phpMyAdmin, listening on port 5000 and linked with the MySQL database. PhpMyAdmin needs its own nginx server. The Load Balancer should be able to redirect directly to this service.
- A container with annginx server listening on ports 80 and 443. Port 80 will be in http and should be a systematic redirection of type 301 to 443, which will be in https. The page displayed does not matter as long as it is not an http error. This container will allow access to a /wordpress route that makes a redirect 307 to IP:WPPORT. It should also allow access to /phpmyadmin with a reverse proxy to IP:PMAPORT.
- A FTPS server listening on port 21.
- A Grafana platform, listening on port 3000, linked with an InfluxDB database. Grafana will be monitoring all containers. There is one dashboard per service. InfluxDB and grafana will be in two distincts containers.
- In case of a crash or stop of one of the two database containers, you will have to make shure the data persist.
- All containers must restart in case of a crash or stop of one of its component parts.
