#!/bin/bash
# Color codes
GREEN='\033[0;32m'
NC='\033[0m'

check_os_version() {
    # Check if the system is running Ubuntu 22.04
    os_release=$(lsb_release -r)
    if [[ "$os_release" == *"22.04"* ]]; then
        echo -e "${GREEN}System is running Ubuntu 22.04${NC}"
    else
        echo "This script is designed to run on Ubuntu systems running 22.04 only."
        echo "Exiting..."
        exit 1
    fi
}

install_docker() {
    ISACT=$(systemctl is-active docker 2>&1)

    if [[ "$ISACT" != "active" ]]; then
        echo -e "${GREEN}Installing Docker-CE (Community Edition)...${NC}"
        sleep 2s

        curl -fsSL https://get.docker.com | sh >> ~/docker-script-install.log 2>&1

        echo -e "${GREEN}Docker-CE version is now:${NC}"
        DOCKERV=$(docker -v)
        echo "          "${DOCKERV}
        sleep 3s

        echo -e "${GREEN}Starting Docker Service${NC}"
        systemctl start docker >> ~/docker-script-install.log 2>&1

        echo -e "${GREEN}Attempting to add the currently logged-in user to the docker group...${NC}"
        sleep 2s
        sudo usermod -aG docker "${USER}" >> ~/docker-script-install.log 2>&1
        echo -e "${GREEN}You'll need to log out and back in to finalize the addition of your user to the docker group.${NC}"
        echo ""
        sleep 3s
    else
        echo -e "${GREEN}Docker is installed and running.${NC}"
        echo ""
    fi
}