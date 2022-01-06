#!/bin/bash

# Update OS
sudo apt-get -y update

# Create base dir for downloading binaries
mkdir ~/Downloads/env_setup
cd ~/Downloads/env_setup

###################################################
################## CLI TOOLS ######################
###################################################

touch ~/.bashrc

echo "
###################################################
#################### CUSTOM #######################
###################################################" >> ~/.bashrc

# Basics to get started
sudo apt-get -y install libcurl3
sudo apt-get -y install curl
sudo apt-get -y install wget
sudo apt-get -y install vim
sudo apt-get -y install traceroute

# Git
read -p "Git user name: " gitUserName
read -p "Git user email: " gitEmail

sudo apt-get -y install git
git config --global user.email "$gitEmail"
git config --global user.name "$gitUserName"

# OpenSSL
sudo apt-get -y install openssl

# libgconf
sudo apt-get -y install libgconf2-4

# .NET Core
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get -y install apt-transport-https
sudo apt-get -y update
sudo apt-get -y install dotnet-sdk-2.1
sudo apt-get -y install dotnet-sdk-3.1
sudo apt-get -y install dotnet-sdk-5.0
sudo apt-get -y install dotnet-sdk-6.0

# Node.JS
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# npm without sudo
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

echo '
# custom npm binaries
export PATH=~/.npm-global/lib:~/.npm-global/bin:$PATH
' >> ~/.bashrc

source ~/.bashrc

# Golang
sudo apt install -y golang

# Docker runtime
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

sudo usermod -a -G docker "$USER"

# jq is useful for inspecting Docker containers' JSON
sudo apt-get install -y jq

# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
# with low resources minikube tends to behave unpredictably
minikube delete
minikube config set memory 8192
minikube config set cpus 4
minikube start
minikube kubectl -- get po -A

# autocomplete for kubectl with alias

mkdir ~/.bash_completion.d
curl https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias \
     > ~/.bash_completion.d/complete_alias

echo "
# Autocomplete for aliases
source ~/.bash_completion.d/complete_alias" >> ~/.bashrc

echo '
# minikube kubectl alias "k" autocomplete
source <(minikube completion bash)
alias k="minikube kubectl --"
complete -F _complete_alias k' >> ~/.bashrc
