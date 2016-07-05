#!/usr/bin/env bash

sudo mkdir -p /etc/cni/net.d
sudo mkdir -p /opt/cni/bin

# Add example Mesos CNI plugin configuration
echo '{
"name": "cni-test",
"type": "bridge",
"bridge": "mesos-cni0",
"isGateway": true,
"ipMasq": true,
"ipam": {
    "type": "host-local",
    "subnet": "192.168.0.0/16",
    "routes": [
    { "dst":
      "0.0.0.0/0" }
    ]
  }
}' | sudo tee /etc/cni/net.d/bridge.conf


# Install go:
sudo curl -O https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
sudo tar -xvf go1.6.linux-amd64.tar.gz
sudo mv go /usr/local
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME

# Install CNI plugins
git clone https://github.com/containernetworking/cni.git
cd cni
git checkout v0.3.0
./build
sudo cp bin/* /opt/cni/bin

# # Start a container to ping. It will only be pingable from the same host.
# sudo mesos-execute --command='ifconfig ; sleep 9999999' --docker_image=amouat/network-utils --master=ec2-52-16-230-26.eu-west-1.compute.amazonaws.com:5050 --name=pingme --networks=cni-test
# # Then log on to the machine that the task was started. E.g. if it started on S0, log onto SLAVE0. Then you can:
# ping 192.168.0.2 # Or whatever IP it started on.
# # When in bridge mode, the container connects to an internal network local to that host. Hence, the pinger must run on the same machine as the pingme. So restart as many times as necessary to get it running on the same host.
# # Get the ip address from the first container.
# sudo mesos-execute --command='ifconfig && ping -v -c 1 192.168.0.2 && sleep 99999' --docker_image=amouat/network-utils --master=ec2-52-16-230-26.eu-west-1.compute.amazonaws.com:5050 --name=pinger --networks=cni-test
