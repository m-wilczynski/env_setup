#!/bin/bash

# Update OS
sudo apt-get -y update

# Create base dir for downloading binaries
mkdir ~/Downloads/env_setup
cd ~/Downloads/env_setup

###################################################
################## CLI TOOLS ######################
###################################################

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

# Golang
sudo apt install -y golang

# Powershell Core
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/20.04/prod.list
sudo apt-get install -y powershell-preview

# Microsoft SQL Server
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2017.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

# PostgreSQL
sudo apt install -y postgresql postgresql-contrib

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

# Omni DB
wget -O ~/Downloads/env_setup/omnidb-app_2.9.0-debian-amd64.deb "https://omnidb.org/dist/2.9.0/omnidb-app_2.9.0-debian-amd64.deb"
sudo dpkg -i ~/Downloads/env_setup/omnidb-app_2.9.0-debian-amd64.deb

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


###################################################
################# CLEANUP #########################
###################################################
rm -rf ~/Downloads/env_setup
