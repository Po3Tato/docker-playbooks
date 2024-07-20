#!/usr/bin/env bash

set -euo pipefail

if ! command -v sudo > /dev/null; then
    echo "Run as root or with sudo"
    exit 1
fi

check_sudo() {
    if [ "$SUDO_USER" ]; then
        return 0
    else
        echo "Not running with elevated privileges. Exiting."
        exit 1
    fi
}

# Set up Docker's apt repository
docker_repo() {
    echo "Setting up Docker repository..."
    apt update -y
    apt install -y ca-certificates curl
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update -y
}

# Install Docker packages
install_docker() {
    echo "Installing Docker..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Create docker group and add user
setup_docker_group() {
    read -p "Would you like to create the 'docker' group and add $USER? (Y/N) " response
    case "$response" in
        ([yY][eE][sS]|[yY]|'')
        groupadd -f docker
        usermod -aG docker "$SUDO_USER"
            ;;
        * ) 
        echo "Skipping docker group creation and user addition."
            ;;
    esac
}

main() {
    check_sudo
    docker_repo
    install_docker
    setup_docker_group
    echo "Docker installed successfully!"
}

main
