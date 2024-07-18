#!/usr/bin/env bash

set -e

# check for sudo/root
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "Run as root or with sudo"
        exit 1
    fi
}

# set up Docker's apt repository
setup_docker_repo() {
    echo "Setting up Docker repository..."
    apt-get update
    apt-get install -y ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
}

# install Docker packages
install_docker() {
    echo "Installing Docker..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# create docker group and add user
setup_docker_group() {
    echo "Do you want to create the docker group and add your user? (Y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY]|)$ ]]; then
        groupadd -f docker
        usermod -aG docker "$SUDO_USER"
        echo "Docker group created and user added. Please log out and back in for changes to take effect."
    else
        echo "Skipping docker group creation and user addition."
    fi
}

main() {
    check_sudo
    setup_docker_repo
    install_docker
    setup_docker_group
    echo "Docker installed successfully!"
}

main
