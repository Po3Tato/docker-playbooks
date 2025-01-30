## Getting Started

This repository contains a collection of Docker Compose files for various applications. To get started, simply clone this repository and navigate to the desired playbook folder.

Each playbook has its own `README.md` file with "instructions" on how to use it.

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
* [Striling-PDF](Striling-PDF/): Self-hosted push notification system. [More info](https://docs.stirlingpdf.com/Installation/Docker%20Install)
* [Vaultwarden](Vaultwarden/): Self-hosted password manager. Can be used with Bitwarden interface [More info](https://github.com/dani-garcia/vaultwarden?tab=readme-ov-file#docker-compose)

## To-Do List

Some ideas for future playbooks include:

* Running K8s using incus-OS
* Creating containerized services for databases
