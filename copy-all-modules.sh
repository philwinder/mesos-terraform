#!/bin/bash
set -x

./copy-modules.sh $MASTER /Volumes/source/clusterhq/mesos-module-flocker
./copy-modules.sh $SLAVE0 /Volumes/source/clusterhq/mesos-module-flocker
./copy-modules.sh $SLAVE1 /Volumes/source/clusterhq/mesos-module-flocker
./copy-modules.sh $SLAVE2 /Volumes/source/clusterhq/mesos-module-flocker

./restart-cluster.sh
