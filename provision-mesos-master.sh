#!/bin/bash

printf 'zk://%s:2181/mesos' "$1" | sudo tee /etc/mesos/zk
printf '%s' "$1" | sudo tee /etc/mesos-master/hostname
printf '%s' "$1" | sudo tee /etc/marathon/conf/hostname
sudo sh -c "echo manual > /etc/init/mesos-slave.override"
sudo service zookeeper restart
sudo service mesos-master stop
sudo service marathon restart
