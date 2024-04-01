# Single Sign-On with Authentik

## Introduction

Single Sign-On (SSO) system, enabling access to multiple services with just one secure login credential.

## Prerequisites

- Docker and Docker Compose installed on a host accessible from the internet
- A domain or subdomain that you own and can set up DNS records for
- Nginx Proxy Manager (or another reverse proxy solution of your choice)
- An SMTP email server for sending notifications and password reset emails

## Installation

1. **Install Docker, Docker Compose, and Nginx Proxy Manager**

    You can easily install the required software by running a simple script:

    ```
    wget https://gitlab.com/bmcgonag/docker_installs/-/raw/main/install_docker_nproxyman.sh
    chmod +x ./install_docker_nproxyman.sh
    ./install_docker_nproxyman.sh
    ```

    This script will guide you through the installation process and allow you to select the components you want to install.
    Thanks to [Awesome Open Source](https://www.youtube.com/@AwesomeOpenSource) for this script.

2. **Configure and Install Authentik**

    Create a directory structure for Authentik:
    ```
    mkdir -p docker/authentik
    ```

    Create the Docker Compose file and paste the provided docker-compose.yml:
    ```
    nano docker/authentik/docker-compose.yml
    ```

    Make a `.env` file,and update with database passwords, SMTP settings, and Authentik secret key.
    ```
    nano .env
    ```

3. **Start Authentik**

    Use the following commands to start Authentik:

    ```
    docker compose up -d && docker compose logs -f
    ```

    This will pull the Docker images, start the containers in the background, and display the logs.

4. **Set up the Reverse Proxy**

    Log in to Nginx Proxy Manager and add a new proxy host for your domain. Configure SSL/TLS settings and request a Let's Encrypt certificate.

5. **Configure Authentik**

    Create an admin user by visiting `https://your-domain.com/if/flow/initial-setup/` and follow the prompts.

