#!/bin/bash


### Install the dependecies and certificates.
sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update


###Install docker- CE edition, and giving the Docker's user permissions to run commands without sudo.
sudo apt install docker-ce -y
sudo groupadd docker
sudo usermod -aG docker ${USER}
newgrp docker


### Test that Docker doesn't need sudo permissions.
docker ps
