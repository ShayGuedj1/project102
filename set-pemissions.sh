#!/bin/bash


echo 'Starting Terraform:'
sleep 5
#sudo chown jenkins:jenkins /home/ubuntu/.ssh/master
sudo touch /home/ubuntu/ips.json
sudo touch /home/ubuntu/inventory.yaml
sudo touch /home/ubuntu/hosts
sudo chmod 777 /home/ubuntu/hosts
sudo chmod 777 /home/ubuntu/ips.json
sudo chmod 777 /home/ubuntu/.ssh
sudo chmod 777 set-ip-ansible.py
sudo chmod 777 /home/ubuntu/inventory.yaml
sudo chmod 777 convert-ip.sh
terraform init


