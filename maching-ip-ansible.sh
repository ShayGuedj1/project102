#!/bin/bash

file1=`cat ip`
echo $file1

ssh-copy-id -i /home/ubuntu/.ssh/id_rsa.pub ubuntu@$file1

ansible-playbook -i $file1, -u ubuntu ansible/install-services.yaml
ansible-playbook -i $file1, -u ubuntu ansible/install-website.yaml
