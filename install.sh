#!/bin/bash


echo 'Starting Terraform:'
sleep 1
sudo chown jenkins:jenkins /home/ubuntu/.ssh/master.pem
terraform init
sleep 3
echo 'terraform apply'
terraform apply --auto-approve
sleep 2
echo 'output of the ip'
terraform output -json > /home/ubuntu/ips.json

cat /home/ubuntu/ips.json
