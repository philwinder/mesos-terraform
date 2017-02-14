#!/bin/bash
set -x

echo "Using AWS key ID $2 for IP $1"

# MASTER
# Setup
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
. /etc/lsb-release
DISTRO=$(echo $DISTRIB_ID | tr '[:upper:]' '[:lower:]')
CODENAME=$(echo $DISTRIB_CODENAME)
# Add the repository
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME}-testing main" | sudo tee -a /etc/apt/sources.list.d/mesosphere.list
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get -y update
# Install
sudo apt-get -y install openjdk-8-jre python-minimal python-pip
sudo update-alternatives --config java
# Install mesos and marathon
sudo apt-get -y install mesos=1.1.0-2.0.107.ubuntu1604 marathon=1.3.0-1.0.506.ubuntu1604

 # Install docker
curl -sSL https://get.docker.com/ | sh
