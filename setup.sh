#!/bin/bash

RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
PURPLE="\e[95m"
CYAN="\e[96m"
WHITE="\e[97m"

minikube start --driver=virtualbox


echo -en $YELLOW
echo "MINIKUBE STARTING..."

minikube addons enable metrics-server
minikube addons enable dashboard &> /dev/null
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.1/manifests/metallb.yaml
kubectl apply -f srcs/metallb.yaml

eval $(minikube docker-env)

echo -en $GREEN
echo "IMAGES BUILDING..."

docker build -t my-nginx srcs/nginx/ | grep "Step"
kubectl apply -f srcs/nginx.yaml

docker build -t my-mysql srcs/mysql/ | grep "Step"
kubectl apply -f srcs/mysql.yaml

docker build -t my-phpmyadmin srcs/phpmyadmin/ | grep "Step"
kubectl apply -f srcs/phpmyadmin.yaml

docker build -t my-wordpress srcs/wordpress/ | grep "Step"
kubectl apply -f srcs/wordpress.yaml

docker build -t my-ftps srcs/ftps/ | grep "Step"
kubectl apply -f srcs/ftps.yaml

docker build -t my-influxdb srcs/influxdb/ | grep "Step"
kubectl apply -f srcs/influxdb.yaml

docker build -t my-grafana srcs/grafana/ | grep "Step"
kubectl apply -f srcs/grafana.yaml

sleep 5

echo -en $WHITE

echo "GET SERVICES!!"
kubectl get svc

echo -en $CYAN

echo "=======HOME======="
echo 'http://192.168.99.112'
echo "-----------------------"


#Conectarse a un pod (cambiar mysql por el pod que quieras)
#kubectl exec -it $(kubectl get pods | grep mysql | cut -d" " -f1) -- sh
#sudo kubectl cp <podname>:/usr/share/grafana/data/ .
#instalar tar dentro de pod apk add tar
#/usr/share/grafana/data