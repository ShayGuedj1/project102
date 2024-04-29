#!/bin/bash

file1=`cat ip`
echo $file1


ansible-playbook -i $file1, -u ubuntu ansible/install-services.yaml
ansible-playbook -i $file1, -u ubuntu ansible/install-website.yaml
