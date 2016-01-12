# mesos-flocker-terraform

This terraform/bash script will create a cluster of one master and three agents in a Mesos cluster.

## Prerequisites
1. An AWS account, a AWS key and secret and an SSH key that has been uploaded or generated on AWS.
2. Terraform

## Usage
1. cd into this repo
2. set variables

    ```bash
    export TF_VAR_access_key=<AWS_ACCESS_KEY_ID> # e.g. ABADNBVDBVNBVFUQEO6Q
    export TF_VAR_secret_key=<AWS_SECRET_ACCESS_KEY> # e.g. L7ffJdcdSGhsbhsfJDBfd74Ta1YDnYhZ68xtj/lv
    export TF_VAR_private_key_file=<private ssh key file> # e.g. key.pem
    export TF_VAR_aws_key_name=<AWS SSH KEY NAME> # e.g. key
    ```

3. `terraform plan`
4. `terraform apply` 
5. Copy and paste the output of the terraform script into your shell, to export the necessary env vars

After a few minutes, this will have provisioned four new machines with the most recent version of Mesos and Docker. The copy paste variables at the output represent the machine addresses and the ssh key location. You can then curl the machines as normal.

If any one of these steps fail, something went wrong. Please debug. ;-)


