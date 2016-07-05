#!/bin/bash

sudo service zookeeper stop
sudo sh -c "echo manual > /etc/init/zookeeper.override"
sudo service mesos-master stop
sudo sh -c "echo manual > /etc/init/mesos-master.override"
echo 'docker,mesos' | sudo tee /etc/mesos-slave/containerizers
echo 'ports(*):[80-80, 31000-32000]' | sudo tee /etc/mesos-slave/resources
printf 'zk://%s:2181/mesos' "$1" | sudo tee /etc/mesos/zk
printf '%s' "$2" | sudo tee /etc/mesos-slave/hostname
echo '5mins' | sudo tee /etc/mesos-slave/executor_registration_timeout
echo 'docker' | sudo tee /etc/mesos-slave/image_providers
echo 'filesystem/linux,docker/runtime' | sudo tee /etc/mesos-slave/isolation
echo '/var/lib/mesos' | sudo tee /etc/mesos-slave/work_dir

sudo service mesos-slave restart
sudo usermod -a -G docker ubuntu