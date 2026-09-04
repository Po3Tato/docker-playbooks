# docker-dev-minimal

A minimal [Coder](https://coder.com) template that provisions developer
workspaces as Docker containers. Based on
[Coder's official Docker starter template](https://github.com/coder/coder/tree/main/examples/templates/docker).

## What it does

- Provisions each workspace as an ephemeral Docker container
  (built from `./build/Dockerfile`, Ubuntu 24.04 base)
- Persists `/home/<user>` in a Docker volume across stop/start and workspace
  renames
- Runs the Coder agent so you can connect via SSH (`coder ssh`), VS Code
  Desktop, JetBrains Gateway, or the terminal in the dashboard
- Sets Git author/committer env vars from your Coder profile
- Shows CPU, RAM and home-disk usage in the dashboard

Deliberately **not** included (add later if needed via
[Coder Registry modules](https://registry.coder.com)): web IDEs, dotfiles
automation, dev containers.

## Requirements

- A Coder deployment (tested against v2.36.x)
- Docker on the Coder host (or a reachable remote Docker daemon)
- The container needs outbound `curl` access to the Coder server URL

## Parameters

| Name            | Default | Description                                              |
| --------------- | ------- | -------------------------------------------------------- |
| `docker_socket` | `""`    | Optional Docker socket URI (e.g. `tcp://host:2375`). Empty = local socket |
| `cpu`           | `2`     | CPU cores allocated to the container (1–32)              |
| `memory`        | `2048`  | Memory in MB (512–65536)                                 |

## Deploy

From this directory:

```sh
coder login https://coder.example.com
coder templates push docker-dev-minimal
```

Or zip the files (`main.tf`, `variables.tf`, `build/Dockerfile`) and upload
via **Templates > Create Template > Upload template** in the dashboard.

Create a workspace:

```sh
coder create --template="docker-dev-minimal" my-workspace
```

## Notes

- The Docker image is rebuilt automatically when any file in `build/` changes
  (SHA1 trigger on the Dockerfile).
- The home volume is protected with `lifecycle { ignore_changes = all }` and
  named from the immutable workspace ID, so accidental template edits won't
  destroy user data. Delete volumes manually when they're truly no longer
  needed: `docker volume rm coder-<workspace-id>-home`.
