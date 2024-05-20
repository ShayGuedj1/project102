#!/bin/bash


echo 'Starting Terraform:'
sleep 1
#sudo chown jenkins:jenkins /home/new_home/.ssh/master
terraform init
sleep 3
echo 'terraform apply'
terraform apply --auto-approve
sleep 2
#sudo chown ubuntu:ubuntu /home/new_home/.ssh/master
echo 'output of the ip'
terraform output -json > /home/new_home/ips.json

cat /home/new_home/ips.json #ips.json is the file that copy the IP into the inventory.
