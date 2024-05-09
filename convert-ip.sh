#1/bin/bash

sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/master
echo 'output of the ip'
terraform output -json > /home/ubuntu/ips.json
cat /home/ubuntu/ips.json #ips.json is the file that copy the IP into the inventory.