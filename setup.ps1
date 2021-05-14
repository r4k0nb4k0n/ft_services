# Welcome!

echo "\n# ************************ #"
echo "#  ft_services by hyechoi  #"
echo "# ************************ #\n"

# Check dependencies.

echo "___Check dependencies.___\n"

## Check if docker is available.

#echo "___Check if Docker is available.___"
#get-command docker
#if ( $lastexitcode -ne 0 ) {
#	echo "Docker is unavailable.\n"
#	exit $lastexitcode
#}
#pgrep -x Docker
#if ( $lastexitcode -ne 0 ) {
#	echo "Docker for Mac is not running. Run 'open -g -a Docker'.\n"
#	exit $?
#}

## Check if virtualbox is available.

#echo "___Check if VirtualBox is available.___"
#get-command virtualbox
#if ( $lastexitcode -ne 0 ) {
#	echo "VirtualBox is unavailable.\n"
#	exit $?
#}

## Check if minikube is available.

echo "___Check if Minikube is available.___"
get-command minikube
if ( $lastexitcode -ne 0 ){
	echo "Minikube is unavailable.\n"
	exit $?
}

# minikube delete before minikube start.
minikube delete
minikube delete --all

# Run minikube.
echo "\n___Run minikube start with Hyper-V vm driver.___"
minikube config set memory 2000 
minikube config set disk-size 4000
minikube start --wait=false --vm-driver=hyperv
if ( $lastexitcode -ne 0 ){
	echo "Can't 'minikube start'.\n"
	exit $?
}

# Install metallb.

echo "\n___Install metallb.___"
minikube addons enable metallb
$MINIKUBE_IP=minikube ip
sed "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/metallb/manifests/configmap.yaml > ./configmap_sed.yaml
kubectl apply -f ./configmap_sed.yaml
rm -Force ./configmap_sed.yaml

# Link minikube to local docker.

echo "\n___Link minikube to local docker.___"
& minikube -p minikube docker-env --shell powershell | Invoke-Expression

# Build container images in need.

echo "\n___Build container images in need.___"
echo "___Build ft-nginx.___"
docker build ./srcs/nginx/ -t alpine:ft-nginx --build-arg minikube_ip=$MINIKUBE_IP
echo "___Build ft-mysql.___"
docker build ./srcs/mysql/ -t alpine:ft-mysql
echo "___Build ft-phpmyadmin.___"
docker build ./srcs/phpmyadmin/ -t alpine:ft-phpmyadmin
echo "___Build ft-wordpress.___"
docker build ./srcs/wordpress/ -t alpine:ft-wordpress
echo "___Build ft-ftps.___"
docker build ./srcs/ftps/ -t alpine:ft-ftps --build-arg minikube_ip=$MINIKUBE_IP

# Apply container images to kube.
 
echo "\n___Apply container images to kube.___"
kubectl apply -f ./srcs/secrets.yaml
kubectl apply -f ./srcs/nginx/manifest.yaml
kubectl apply -f ./srcs/mysql/manifest.yaml
kubectl apply -f ./srcs/phpmyadmin/manifest.yaml
kubectl apply -f ./srcs/wordpress/manifest.yaml
kubectl apply -f ./srcs/ftps/manifest.yaml

# Enable dashboard, metrics-server.

echo "\n___Enable dashboard, metrics-server.___"
minikube addons enable dashboard
minikube addons enable metrics-server

echo "\n___Run dashboard on background.___"
minikube dashboard &
