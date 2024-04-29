#!/bin/bash

echo 'Starting Terraform: '
sleep 3
terraform apply 
sleep 3

echo 'Starting service installation: '
sleep 2
ansible-playbook -i aws_ec2.yaml ansible/install-services.yaml
sleep 3

echo 'Starting website configuration, please wait: '
ansible-playbook -i aws_ec2.yaml ansible/install-website.yaml
sleep 3