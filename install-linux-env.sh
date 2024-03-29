#!/bin/bash
DOCKER_ENV=`dpkg -l | grep docker`

echo "Start install Env, please run with Root Privileges"
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

if [ -z "$DOCKER_ENV" ]
	then
	       echo "installing Docker Env"
               apt-get -y install apt-transport-https ca-certificates curl  gnupg-agent software-properties-common
               curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
               apt-key fingerprint 0EBFCD88
               add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
               apt-get update && apt-get install docker-ce docker-ce-cli containerd.io                                           
	
	else
             echo "Docker already installed" 
fi