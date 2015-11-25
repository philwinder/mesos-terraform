#!/bin/bash
set -x

scp -i $KEY $2/modules.json ubuntu@$1:~
scp -i $KEY $2/bin/libisolator.so ubuntu@$1:~
ssh -i $KEY ubuntu@$1 'printf /home/ubuntu/modules.json | sudo tee /etc/mesos-master/modules'
ssh -i $KEY ubuntu@$1 'printf /home/ubuntu/modules.json | sudo tee /etc/mesos-slave/modules'


ssh -i $KEY ubuntu@$1 'printf com_clusterhq_flocker_FlockerIsolator | sudo tee /etc/mesos-slave/isolation'
