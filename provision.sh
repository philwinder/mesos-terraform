#!/bin/bash

echo "Using AWS key ID $2 for IP $1"

# MASTER
# Setup 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF 
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') 
CODENAME=$(lsb_release -cs)  
# Add the repository 
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list 
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get -y update
# Install
sudo apt-get -y install openjdk-8-jre
sudo update-alternatives --config java 
# Install mesos and marathon
sudo apt-get -y install mesos marathon

 # Install docker
curl -sSL https://get.docker.com/ | sh


