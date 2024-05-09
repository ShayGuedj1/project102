#!/bin/bash


echo 'Starting Terraform:'
sleep 1
sudo chown jenkins:jenkins /home/ubuntu/.ssh/master
sh 'sudo touch /home/ubuntu/ips.json'
sh 'sudo touch /home/ubuntu/inventory'
sh 'sudo touch /home/ubuntu/hosts'
sh 'sudo chmod 777 /home/ubuntu/hosts'
sh 'sudo chmod 777 /home/ubuntu/ips.json'
sh 'sudo chmod 777 /home/ubuntu/.ssh'
sh 'sudo chmod 777 set-ip-ansible.py'
sh 'sudo chmod 777 install.sh'
sh 'sudo chmod 777 /home/ubuntu/inventory'
sh 'sudo chmod 777 convert-ip.sh'
terraform init


