# docker_installs
This script will help install any, or all, of Docker-CE, Docker-Compose, NGinX Proxy Manager, and Portainer-CE.

## Using this script

1. `wget` the repository

`wget https://github.com/Po3Tato/docker_install](https://github.com/Po3Tato/homelab-doc/tree/main/Docker-install`

2. Change the permissions of the .sh file to make it executable with.

`chmod +x ./install_docker_nginxproxy.sh`

3. Run the installer with

`./install_docker_nginxproxy.sh`

## Prompts from the script:
First, you'll be prompted to select the number for your OS / Distro. 

Next, you'll be asked to answer "y" to any of the four software packages you'd like to install. 
- Docker-CE
- Docker-Compose
- NGinx Proxy Manager
- Portainer-CE
  - if you answer y to Portainer, you'll be asked another question

Do you want 
  1. full Portainer-CE with the web UI, or 
  2. just Portainer-agent (which you connect to another full portainer instance). 

Make that selection, and the install will continue.

Answering "n" to any of them will cause them to be skipped.

### NOTE
* You must have Docker-CE (or some version of Docker) installed in order to run any of the other three packages.
* You must have Docker-Compose installed in order to run NGinX Proxy Manager, Portainer-CE, or Navidrome with this script.

Before prompting to install Docker or Docker-Compose, I do try to see if you already have them installed, and I skip the prompt if you do (or I try to anyway).


## Contributors
@jude thanks to https://gitlab.com/bmcgonag
