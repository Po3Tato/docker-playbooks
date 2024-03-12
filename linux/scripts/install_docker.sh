#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

check_success() {
  if [ $? -ne 0 ]; then
    echo "An error occurred. Exiting..."
    exit 1
  fi
}

ask_continue() {
  read -p "Do you want to continue? (y/n): " yn
  if [[ ! $yn =~ ^[Yy]$ ]]; then
    echo "User chose not to continue. Exiting..."
    exit
  fi
}

echo "Checking if you are running Ubuntu 22.04..."
ubuntu_version=$(lsb_release -rs)
if [ "$ubuntu_version" = "22.04" ]; then
  echo -e "${GREEN}You are running Ubuntu 22.04. The script will now proceed.${NC}"
else
  echo -e "${RED}You are not running Ubuntu 22.04. This script is intended for Ubuntu 22.04 only.${NC}"
  exit 1
fi
ask_continue

echo "Installing ca-certificates and curl..."
sudo apt-get install ca-certificates curl -y
check_success

echo "Creating /etc/apt/keyrings directory..."
sudo install -m 0755 -d /etc/apt/keyrings
check_success

echo "Adding Docker's official GPG key..."
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
check_success

echo "Setting permissions for the GPG key..."
sudo chmod a+r /etc/apt/keyrings/docker.asc
check_success

echo "Adding the Docker repository to Apt sources..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
check_success

echo "Updating package lists after adding Docker repository..."
sudo apt-get update
check_success

ask_continue

echo "All steps completed successfully. You can now install Docker by running:"
echo "sudo apt-get install docker-ce docker-ce-cli containerd.io"
