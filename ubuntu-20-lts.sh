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

# Curl and wget
sudo apt-get -y install libcurl3
sudo apt-get -y install curl
sudo apt-get -y install wget
sudo apt-get -y install vim

# Git
read -p "Git user name: " gitUserName
read -p "Git user email: " gitEmail

sudo apt-get -y install git
git config --global user.email "$gitUserName"
git config --global user.name "$gitEmail"

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

# Node.JS
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# npm without sudo
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

echo "
# custom npm binaries
export PATH=~/.npm-global/bin:$PATH
" >> ~/.bashrc

source ~/.bashrc

# Golang
sudo apt install -y golang

# Microsoft SQL Server
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

# PostgreSQL
sudo apt install -y postgresql postgresql-contrib

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
sudo apt-get -y jq

###################################################
################## GUI TOOLS ######################
###################################################

# VS Code
wget -O ~/Downloads/env_setup/vscode-amd64.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i ~/Downloads/env_setup/vscode-amd64.deb

# Git Kraken
sudo apt-get -y install gconf2
wget -O ~/Downloads/env_setup/gitkraken-amd64.deb "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
sudo dpkg -i ~/Downloads/env_setup/gitkraken-amd64.deb

# Firefox
sudo apt-get -y install firefox

# Azure Data Studo
wget -O ~/Downloads/env_setup/azuredatastudio.deb "https://go.microsoft.com/fwlink/?linkid=2165738"
sudo dpkg -i ~/Downloads/env_setup/azuredatastudio.deb

# Spotify
sudo apt-get -y install snapd
sudo snap install spotify



###################################################
################# CUSTOM THEME ####################
###################################################

# Fonts
sudo apt-get -y install fonts-roboto-hinted
sudo apt-get -y install fonts-noto-hinted
sudo apt-get -y install fonts-firacode

# Orchis theme
sudo apt-get install -y gnome-themes-extra
sudo apt-get install -y gnome-tweaks
sudo apt-get install -y gtk2-engines-murrine
sudo apt-get install -y sassc
sudo apt-get install -y unzip

mkdir orchis && wget -O ~/Downloads/env_setup/orchis/master.zip "https://github.com/vinceliuice/Orchis-theme/archive/refs/heads/master.zip" 
cd orchis && unzip master.zip && cd Orchis-theme-master && bash install.sh

# Paper Icons
sudo add-apt-repository -y ppa:snwh/ppa
sudo apt-get -y install paper-icon-theme

# Terminal theme
cd ~/Downloads/env_setup/ && wget "https://raw.githubusercontent.com/sonph/onehalf/master/gnome-terminal/onehalfdark.sh" && bash onehalfdark.sh

# TODO: Script fonts and GNOME Tweak Tool outpot with gsettings

# TODO: Wallpaper? :)

###################################################
################# CLEANUP #########################
###################################################
rm -rf ~/Downloads/env_setup
