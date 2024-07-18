#!/usr/bin/env bash

set -euo pipefail
# check for sudo/root
check_sudo() {
    if [ "$EUID" != 0 ]; then
        echo "Run as root or with sudo"
        exit 1
    fi
}

# set up Docker's apt repository
setup_docker_repo() {
    echo "Setting up Docker repository..."
    apt update -y
    apt install -y ca-certificates curl
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update -y
}

# install Docker packages
install_docker() {
    echo "Installing Docker..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# create docker group and add user
setup_docker_group() {
    read -r -p "Do you want to create the docker group and add your user? (Y/n) " response
    case "$response" in
        ([yY][eE][sS]|[yY]|'') )
        groupadd -f docker
        usermod -aG docker "$SUDO_USER"
        echo "Docker group created and user added. Please log out and back in for changes to take effect."
            ;;
        * ) 
        echo "Skipping docker group creation and user addition."
            ;;
    esac
}

main() {
    check_sudo
    setup_docker_repo
    install_docker
    setup_docker_group
    echo "Docker installed successfully!"
}

main
