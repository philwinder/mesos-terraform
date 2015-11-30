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

# Flocker
sudo apt-get update
sudo apt-get -y install apt-transport-https software-properties-common
sudo add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /"
sudo apt-get update
sudo apt-get -y --force-yes install clusterhq-flocker-node clusterhq-flocker-docker-plugin
sudo mkdir /etc/flocker
sudo chown ubuntu /etc/flocker

# Setup control
printf 'start on runlevel [2345]\nstop on runlevel [016]\n' | sudo tee /etc/init/flocker-control.override
printf 'flocker-control-api\t4523/tcp\t# Flocker Control API port\n' | sudo tee -a /etc/services
printf 'flocker-control-agent\t4524/tcp\t# Flocker Control Agent port\n' | sudo tee -a /etc/services

# Setup agent
printf '"version": 1
"control-service":
   "hostname": "%s"
   "port": 4524
dataset:
    backend: "aws"
    region: "eu-west-1"
    zone: "eu-west-1b"
    access_key_id: "%s"
    secret_access_key: "%s"
' "$1" "$2" "$3" | sudo tee /etc/flocker/agent.yml


