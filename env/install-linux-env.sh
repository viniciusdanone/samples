#!/bin/bash

echo "Start install Env, please run with Root Privileges"
	sudo su 
	apt-get update
	apt-get install -y awscli

echo "Installing Kubectl Env"
	apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
        apt-get update
        apt-get install -y kubectl

echo "Installing Helm Env"
	curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
        apt-get install apt-transport-https --yes
        echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
        apt-get update
        apt-get install -y helm

echo "Start login in AWS"
	aws login
