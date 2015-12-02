#!/bin/bash
set -x #echo on

# To setup flocker you will need to install the cli tools on your local machine: https://docs.clusterhq.com/en/1.6.1/install/install-client.html

# Export MASTER/SLAVE{0..2} from the terraform apply step.

# Export your generated key
# export KEY=/Volumes/source/clusterhq/terraform/ssh_keys/key.pem

echo "Delete any old certificates and nodes"
rm -rf *.crt *.key ec2*


# Now run the certificate generation scripts
flocker-ca initialize flocker-cluster
flocker-ca create-control-certificate $MASTER
mv control-*.crt control-service.crt
mv control-*.key control-service.key
scp -oStrictHostKeyChecking=no -i $KEY control-service.crt ubuntu@$MASTER:/etc/flocker
scp -oStrictHostKeyChecking=no -i $KEY control-service.key ubuntu@$MASTER:/etc/flocker 
scp -oStrictHostKeyChecking=no -i $KEY ./cluster.crt ubuntu@$MASTER:/etc/flocker
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$MASTER 'sudo chmod 0700 /etc/flocker'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$MASTER 'chmod 0600 /etc/flocker/control-service.key'

ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$MASTER 'sudo service flocker-control stop ; sudo service flocker-dataset-agent stop ; sudo service flocker-container-agent stop ; sudo service docker stop'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$MASTER 'sudo rm /var/lib/docker/network/files/local-kv.db'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$MASTER 'sudo service flocker-control start ; sudo service docker start'

flocker-ca create-api-certificate plugin

# Slaves, change the export name
export SLAVE=$SLAVE0
mkdir $SLAVE
cp cluster.crt $SLAVE/
cp cluster.key $SLAVE/
cd $SLAVE
flocker-ca create-node-certificate
rm cluster.*
mv *.crt node.crt
mv *.key node.key
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo chown ubuntu /etc/flocker'
scp -oStrictHostKeyChecking=no -i $KEY node.crt ubuntu@$SLAVE:/etc/flocker
scp -oStrictHostKeyChecking=no -i $KEY node.key ubuntu@$SLAVE:/etc/flocker 
scp -oStrictHostKeyChecking=no -i $KEY ../cluster.crt ubuntu@$SLAVE:/etc/flocker
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo chmod 0700 /etc/flocker'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'chmod 0600 /etc/flocker/node.key'
cd ..
scp -oStrictHostKeyChecking=no -i $KEY ./plugin.crt ubuntu@$SLAVE:/etc/flocker/plugin.crt
scp -oStrictHostKeyChecking=no -i $KEY ./plugin.key ubuntu@$SLAVE:/etc/flocker/plugin.key
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-control stop ; sudo service flocker-dataset-agent stop ; sudo service flocker-container-agent stop ; sudo service docker stop'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo rm /var/lib/docker/network/files/local-kv.db'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-dataset-agent start'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-container-agent start'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service docker start'


export SLAVE=$SLAVE1
mkdir $SLAVE
cp cluster.crt $SLAVE/
cp cluster.key $SLAVE/
cd $SLAVE
flocker-ca create-node-certificate
rm cluster.*
mv *.crt node.crt
mv *.key node.key
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo chown ubuntu /etc/flocker'
scp -oStrictHostKeyChecking=no -i $KEY node.crt ubuntu@$SLAVE:/etc/flocker
scp -oStrictHostKeyChecking=no -i $KEY node.key ubuntu@$SLAVE:/etc/flocker
scp -oStrictHostKeyChecking=no -i $KEY ../cluster.crt ubuntu@$SLAVE:/etc/flocker
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo chmod 0700 /etc/flocker'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'chmod 0600 /etc/flocker/node.key'
cd ..
scp -oStrictHostKeyChecking=no -i $KEY ./plugin.crt ubuntu@$SLAVE:/etc/flocker/plugin.crt
scp -oStrictHostKeyChecking=no -i $KEY ./plugin.key ubuntu@$SLAVE:/etc/flocker/plugin.key
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-control stop ; sudo service flocker-dataset-agent stop ; sudo service flocker-container-agent stop ; sudo service docker stop'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo rm /var/lib/docker/network/files/local-kv.db'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-dataset-agent start'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-container-agent start'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service docker start'

export SLAVE=$SLAVE2
mkdir $SLAVE
cp cluster.crt $SLAVE/
cp cluster.key $SLAVE/
cd $SLAVE
flocker-ca create-node-certificate
rm cluster.*
mv *.crt node.crt
mv *.key node.key
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo chown ubuntu /etc/flocker'
scp -oStrictHostKeyChecking=no -i $KEY node.crt ubuntu@$SLAVE:/etc/flocker
scp -oStrictHostKeyChecking=no -i $KEY node.key ubuntu@$SLAVE:/etc/flocker
scp -oStrictHostKeyChecking=no -i $KEY ../cluster.crt ubuntu@$SLAVE:/etc/flocker
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo chmod 0700 /etc/flocker'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'chmod 0600 /etc/flocker/node.key'
cd ..
scp -oStrictHostKeyChecking=no -i $KEY ./plugin.crt ubuntu@$SLAVE:/etc/flocker/plugin.crt
scp -oStrictHostKeyChecking=no -i $KEY ./plugin.key ubuntu@$SLAVE:/etc/flocker/plugin.key
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-control stop ; sudo service flocker-dataset-agent stop ; sudo service flocker-container-agent stop ; sudo service docker stop'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo rm /var/lib/docker/network/files/local-kv.db'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-dataset-agent start'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service flocker-container-agent start'
ssh -f -oStrictHostKeyChecking=no -i $KEY ubuntu@$SLAVE 'sudo service docker start'

echo "Now please wait for two minutes whilst the flocker cluster converges (required, sorry)"
sleep 120

echo "Generating user api keys"
flocker-ca create-api-certificate user

# Check it worked (Note, it takes a while for the flocker nodes to join the cluster)
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# LINUX
	curl --cacert $PWD/cluster.crt --cert $PWD/user.crt --key $PWD/user.key https://$MASTER:4523/v1/version
	curl --cacert $PWD/cluster.crt --cert $PWD/user.crt --key $PWD/user.key https://$MASTER:4523/v1/state/nodes
	curl --cacert $PWD/cluster.crt --cert $PWD/user.crt --key $PWD/user.key https://$MASTER:4523/v1/state/datasets
	curl --cacert $PWD/cluster.crt --cert $PWD/user.crt --key $PWD/user.key https://$MASTER:4523/v1/configuration/datasets
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# MAC (due to a bug in mac curl)
	openssl pkcs12 -export -inkey $PWD/user.key -in $PWD/user.crt -name user -out user.p12 -password pass:password
	curl -k --cert user.p12:password https://$MASTER:4523/v1/version
	curl -k --cert user.p12:password https://$MASTER:4523/v1/state/nodes
	curl -k --cert user.p12:password https://$MASTER:4523/v1/configuration/datasets
	curl -k --cert user.p12:password https://$MASTER:4523/v1/state/datasets
fi

