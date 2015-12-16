# mesos-flocker-terraform

This terraform/bash script will create a cluster of one master and three agents in a Mesos cluster, all running flocker. Please note that it uses a provided ssh key for simplicity. If you care about security, generate your own keys.

## Prerequisites
1. An AWS account and a AWS key and secret
2. Terraform
3. The Flocker CLI tools [(flocker-cli)](https://docs.clusterhq.com/en/1.7.2/install/install-client.html#installing-flocker-cli)

## Usage
1. cd into this repo
1. `terraform get .`
1. set variables
    ```bash
    export TF_VAR_access_key=<AWS_ACCESS_KEY_ID> # e.g. ABADNBVDBVNBVFUQEO6Q
    export TF_VAR_secret_key=<AWS_SECRET_ACCESS_KEY> # e.g. L7ffJdcdSGhsbhsfJDBfd74Ta1YDnYhZ68xtj/lv
    export TF_VAR_private_key_file=<private ssh key file> # e.g. key.pem
    export TF_VAR_aws_key_name=<AWS SSH KEY NAME> # e.g. key
    ```
1. `terraform plan`
1. `terraform apply` 
1. Copy and paste the output of the terraform script into your shell, to export the necessary env vars
1. `./provision-certs.sh`
1. Wait.

Optional, if you are using this with the mesos-flocker framework (https://github.com/ClusterHQ/mesos-module-flocker)
7. Compule the .so module file
8. `./copy-all-modules.sh` will copy the modules to the cluster. Edit the file to change the path to the so file (TODO).

After a few minutes, this will have provisioned four new machines with the most recent version of Mesos Docker and Flocker and the curl requests at the end of the file should have resulted in some valid state information.

If any one of these steps fail, something went wrong. Please debug. ;-)


