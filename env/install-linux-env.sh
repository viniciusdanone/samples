#!/bin/bash
DOCKER_ENV=`dpkg -l | grep docker`
HELM_ENV=`dpkg -l | grep helm`
KUBECTL_ENV=`dpkg -l | grep kubectl`
AWS_ENV=`dpkg -l | grep aws`

if [ -z "$AWS_ENV" ]
	then
		echo "Start install Env, please run with Root Privileges"	
                apt-get update
                apt-get install -y awscli
	else
		echo "aws cli alread configured"
fi

if [ -z "$KUBECTL_ENV" ]
	then
		echo "Installing Kubectl Env"
                apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
                curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
                echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
                apt-get update
                apt-get install -y kubectl
	else
             echo "Docker already installed" 
fi

if [ -z "$HELM_ENV" ]
	then
		echo "Installing Helm Env"
                curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
                apt-get install apt-transport-https --yes
                echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
                apt-get update
                apt-get install -y helm

                echo "Install helm s3 plugin"
                        helm plugin install https://github.com/hypnoglow/helm-s3.git

                echo "Install chatfood Repository"
                        helm repo add chatfood-support-locals-web s3://chatfood-helm/charts
                        helm repo add chatfood-marketplace s3://chatfood-helm/charts
                        helm repo add chatfood  s3://chatfood-helm/charts                                     
                        helm repo add chatfood-support-locals-web s3://chatfood-helm/charts                                      
                        helm repo add support-locals-web s3://chatfood-helm/charts  
	else
		echo "Helm already installed"
fi

if [ -z "$DOCKER_ENV" ]
	then
	      	echo "installing Docker Env"                                                                                          
                apt-get -y install apt-transport-https ca-certificates curl  gnupg-agent software-properties-common
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                apt-key fingerprint 0EBFCD88
                add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
                apt-get update && apt-get -y install docker-ce docker-ce-cli containerd.io                                           
		
			service docker start
	else
             echo "Docker already installed" 
fi

echo "Configuring AWS Env"
		aws configure





