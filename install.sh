#!/bin/bash


echo 'Starting Terraform:'
sleep 1
terraform init
sleep 3
echo 'terraform apply'
terraform apply --auto-approve
sleep 2
echo 'output of the ip'
terraform output -json > /home/ubuntu/ips.json

cat /home/ubuntu/ips.json

#echo 'running set-ip-ansible.py'
#python3 set-ip-ansible.py

#echo 'output of ansible:'
#sleep 3
#cat /ansible/inventory