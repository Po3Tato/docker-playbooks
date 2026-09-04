#!/usr/bin/env bash

# Add Docker's official GPG key:
sudo apt-get install ca-certificates curl
sleep 2
sudo install -m 0755 -d /etc/apt/keyrings
sleep 2
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sleep 2
sudo chmod a+r /etc/apt/keyrings/docker.asc
sleep 2
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 2
sudo apt-get update
sleep 1

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sleep 2

echo "Adding user to docker"
sleep 2

sudo usermod -aG docker $USER

echo "$USER has been added to Docker group."
echo "You can go ahead and restart."
