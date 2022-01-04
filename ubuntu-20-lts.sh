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

###################################################
################## GUI TOOLS ######################
###################################################

# VS Code
wget -O ~/Downloads/env_setup/vscode-amd64.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i ~/Downloads/env_setup/vscode-amd64.deb

# Git Kraken
sudo apt-get install -y git-cola

# Azure Data Studo
wget -O ~/Downloads/env_setup/azuredatastudio.deb "https://go.microsoft.com/fwlink/?linkid=2165738"
sudo dpkg -i ~/Downloads/env_setup/azuredatastudio.deb

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

###################################################
################### POWERLINE #####################
###################################################
sudo apt install -y python3-pip
pip3 install --user powerline-status

echo '
# Local bin for pip installs
export PATH=$PATH:$HOME/.local/bin
 
# Powerline configuration
if [ -f $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh ]; then
    $HOME/.local/bin/powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
fi
' >> ~/.bashrc

source ~/.bashrc

pip3 install powerline-gitstatus

# Powerline theme

groupsPath="$HOME/.local/lib/python3.8/site-packages/powerline/config_files/colorschemes/default.json"

jq '
.groups += {"gitstatus":                 { "fg": "gray8",           "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_branch":          { "fg": "gray8",           "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_branch_clean":    { "fg": "green",           "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_branch_dirty":    { "fg": "gray8",           "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_branch_detached": { "fg": "mediumpurple",    "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_tag":             { "fg": "darkcyan",        "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_behind":          { "fg": "gray10",          "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_ahead":           { "fg": "gray10",          "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_staged":          { "fg": "green",           "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_unmerged":        { "fg": "brightred",       "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_changed":         { "fg": "mediumorange",    "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_untracked":       { "fg": "brightestorange", "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus_stashed":         { "fg": "darkblue",        "bg": "gray2", "attrs": [] }} |
.groups += {"gitstatus:divider":         { "fg": "gray8",           "bg": "gray2", "attrs": [] }}
' $groupsPath > tmp.json && mv tmp.json $groupsPath

shellPath="$HOME/.local/lib/python3.8/site-packages/powerline/config_files/themes/shell/default.json"

jq '
del(
    .segments.left[] | 
    select(.function == "powerline.segments.shell.jobnum")
) |
.segments.left += [{
    "function": "powerline_gitstatus.gitstatus",
    "priority": 40
}]' $shellPath > tmp.json && mv tmp.json $shellPath


cd ~/Downloads/env_setup
git clone https://github.com/powerline/fonts.git --depth=1 fonts
./fonts/install.sh

mkdir ~/.config/powerline
mkdir ~/.config/powerline/colorschemes   
mkdir ~/.config/powerline/themes
mkdir ~/.config/powerline/themes/shell

cp $groupsPath ~/.config/powerline/colorschemes
cp $shellPath ~/.config/powerline/themes/shell

# For now - change manually terminal font to Powerline one, for ex. "Source Code Pro for Powerline Medium"

# TODO: Script fonts and GNOME Tweak Tool output with gsettings

# TODO: Wallpaper? :)

###################################################
################# CLEANUP #########################
###################################################
rm -rf ~/Downloads/env_setup
