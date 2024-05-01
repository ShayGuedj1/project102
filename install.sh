#!/bin/bash

echo 'Starting Terraform: '
sleep 3
terraform apply --auro-approve 
sleep 2

terraform output -json > /home/ubuntu/ips.json
