#!/bin/bash

dig +short myip.opendns.com @resolver1.opendns.com > /home/ubuntu/project/project102/ip 
export ANSIBLE_HOST_KEY_CHECKING=False

file1=`cat ip`
echo $file1

ssh-copy-id -i /home/ubuntu/.ssh/id_rsa.pub ubuntu@$file1

ansible-playbook -i $file1, -u ubuntu ansible/install-services.yaml
ansible-playbook -i $file1, -u ubuntu ansible/install-website.yaml
