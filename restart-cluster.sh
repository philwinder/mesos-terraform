#!/bin/bash
set -x

ssh -i $KEY ubuntu@$MASTER 'sudo service mesos-master restart'
ssh -i $KEY ubuntu@$SLAVE0 'sudo service mesos-slave restart'
ssh -i $KEY ubuntu@$SLAVE1 'sudo service mesos-slave restart'
ssh -i $KEY ubuntu@$SLAVE2 'sudo service mesos-slave restart'
