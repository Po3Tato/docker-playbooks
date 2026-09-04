# homelab-doc
 A collection of playbooks along with documention of services I use in my homelab environment.

## Existing Playbooks

The following playbooks are currently part of the collection:

* [Gitea](Gitea/): A simple self-hosted repository. [More info](https://docs.gitea.com/next/installation/install-with-docker)
* [Traefik](Traefik/): A simple dynamic reverse proxy. [More info](https://doc.traefik.io/traefik/user-guides/docker-compose/basic-example/)
* [Glance](Glance/): A simple homelab dashboard. [More info](https://github.com/glanceapp/glance)
* [AI-Stack](AI-Stack/): A combination of Open-WebUI and SearXNG. [More Info Open-WebUI](https://github.com/open-webui/open-webui/blob/main/docker-compose.yaml) | [More Info SearXNG](https://github.com/searxng/searxng-docker/blob/master/docker-compose.yaml)
* [Authentik](Authentik/): A Open-Source SSO solution. [More info](https://version-2021-2.goauthentik.io/docs/installation/docker-compose/)
* [Miniflux](Miniflux/): A minimalist RSS reader. [More info](https://miniflux.app/docs/docker.html)
* [Gotify](Gotify/): Self-Hosted push notification system. [More info](https://gotify.net/docs/install)
* [Uptime-Kuma](Uptime-Kuma/): Self-Hosted monitoring tool with notifications. [More info](https://github.com/louislam/uptime-kuma/blob/master/compose.yaml)
* [Grafana](Grafana/): An open-source tool for data visualization and monitoring through interactive dashboards.
* [Beszel](Beszel): Lightweight monitoring service. Both Hub and Agent use very minimal resources. [More info](https://www.beszel.dev/guide/hub-installation)
* [Striling-PDF](Striling-PDF/): Self-hosted PDF manipulation toolkit. [More info](https://docs.stirlingpdf.com/Installation/Docker%20Install)
* [Vaultwarden](Vaultwarden/): Self-hosted password manager. Can be used with Bitwarden interface [More info](https://github.com/dani-garcia/vaultwarden?tab=readme-ov-file#docker-compose)
* [Vikunja](Vikunja/): Self-hosted to-do app with gnat chart. [More info](https://vikunja.io/)
* [tailscale-lb](tailscale-lb/): Loadbalancer to forward Tailscale TCP traffic, used to set up virtual IPs over a tailnet. [More info](https://github.com/zombiezen/tailscale-lb)
* [Coder-templates](Coder-templates/): Coder workspace templates provisioning resource-limited, unprivileged Docker containers.

## Components

### [Ansible](./Ansible)
- Infrastructure as Code (IaC) for server configuration
- Playbooks for common server setup tasks
- Package installation and SSH hardening

### [Docker Playbooks](./Docker%20Playbooks)
- Docker Compose files for various services

### [Docker Playbooks](./Docker%20Playbooks)
- VM template creation guide for Ubuntu

### [Terraform](./Terraform)
- **Digital Ocean**
    - Infrastructure provisioning for DigitalOcean
    - Droplet creation and project resource management

### [Windows Server](./WindowsServer)
- PowerShell scripts for user and group management
- Active Directory certificate checks

### [Linux](./linux)
- Helpful scripts
    - Docker install script
    - Ollama Install script

## To-Do List

Some ideas for future playbooks include:

* Running K8s using incus-OS
* Creating containerized services for databases

## Getting Started
Each directory contains specific instructions and configurations for different aspects of the homelab. Refer to individual README files or script comments for detailed usage instructions.
