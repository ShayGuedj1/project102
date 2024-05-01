#!/bin/bash

echo 'Starting Terraform: '
sleep 1
terraform init
echo 'terraform apply'
terraform apply --auto-approve 
sleep 2
echo 'output of the ip'
terraform output -json > /home/ubuntu/ips.json

cat /home/ubuntu/ips.json

python3 set-ip-ansible.py

cat /home/ubuntu/project/project102/ansible/inventory