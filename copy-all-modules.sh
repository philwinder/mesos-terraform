#!/bin/bash

if [[ "$1" == "" ]]; then
  echo "Please specify the path to the mesos-module-flocker project."
  exit 1
fi

if [[ ! -e "$1/bin/libisolator.so" ]]; then
  echo "Could not find libisolator in $1/bin/libisolator.so"
  exit 1
fi

./copy-modules.sh $MASTER $1
./copy-modules.sh $SLAVE0 $1
./copy-modules.sh $SLAVE1 $1
./copy-modules.sh $SLAVE2 $1

./restart-cluster.sh
