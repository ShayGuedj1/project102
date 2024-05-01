#!/bin/bash

echo 'Starting Terraform: '
sleep 3
terraform apply --auto-approve 
sleep 2

terraform output -json > /home/ubuntu/ips.json

python3 set-ip-ansible.py

cat /home/ubuntu/project/project102/ansible/inventory