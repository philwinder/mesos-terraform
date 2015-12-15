# mesos-flocker-terraform

This terraform/bash script will create a cluster of one master and three agents in a Mesos cluster, all running flocker. Please note that it uses a provided ssh key for simplicity. If you care about security, generate your own keys.

## Prerequisites
1. An AWS account and a AWS key and secret
2. Terraform
3. The Flocker CLI tools [(flocker-cli)](https://docs.clusterhq.com/en/1.7.2/install/install-client.html#installing-flocker-cli)

## Usage
1. cd into this repo
2. `terraform get .`
3. `terraform plan -var 'access_key=......' -var 'secret_key=......'`
4. `terraform apply -var 'access_key=......' -var 'secret_key=......' .` where you should enter your id and secret appropriately.
5. Copy and paste the output of the terraform script into your shell, to export the necessary env vars
6. `./provision-certs.sh`
7. Wait.

Optional, if you are using this with the mesos-flocker framework (https://github.com/ClusterHQ/mesos-module-flocker)
7. Compule the .so module file
8. `./copy-all-modules.sh` will copy the modules to the cluster. Edit the file to change the path to the so file (TODO).

After a few minutes, this will have provisioned four new machines with the most recent version of Mesos Docker and Flocker and the curl requests at the end of the file should have resulted in some valid state information.

If any one of these steps fail, something went wrong. Please debug. ;-)


