#!/bin/bash
BREW_ENV=`which brew`
DOCKER_ENV=`brew list -1  | grep docker`
HELM_ENV=`brew list -1 | grep helm`
KUBECTL_ENV=`brew list -1 | grep kubectl`
AWS_ENV=`brew list -1 | grep aws`


if [ -z $BREW_ENV ]
        then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		echo "brew alread configured"
                brew update
fi

if [ -z "$AWS_ENV" ]
	then
		echo "Start install Env, please run with Root Privileges"	
                brew install awscli
	else
		echo "awscli alread configured"
fi

if [ -z "$KUBECTL_ENV" ]
	then
                brew install kubectx
                brew install kubectl
	else
             echo "Docker already installed" 
fi

if [ -z "$HELM_ENV" ]
	then
		echo "Installing Helm Env"
                        brew install helm

                echo "Install helm s3 plugin"
                        helm plugin install https://github.com/hypnoglow/helm-s3.git

                echo "Install chatfood Repository"
                        helm plugin install https://github.com/hypnoglow/helm-s3.git
                        helm repo add chatfood  s3://chatfood-helm/charts                                     
                        helm repo add chatfood-stg s3://chatfood-helm-stg/charts
                        helm repo update
	else
		echo "Helm already installed"
fi

if [ -z "$DOCKER_ENV" ]
	then
	      	echo "installing Docker Env"                                                                                          
                brew install docker
	else
             echo "Docker already installed" 
fi

echo "Configuring AWS Env"
		aws configure