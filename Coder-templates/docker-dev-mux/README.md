# Coder Docker Workspace Template

Coder template that provisions a Docker container as a workspace on this host. Same as [docker-dev-env](../docker-dev-env/), plus the [mux](https://registry.coder.com/modules/coder/mux) module for running multiple AI coding agents in parallel with its own web UI.

## What it provisions

- A `codercom/example-node:ubuntu` container (Node.js preinstalled) as the workspace, connected to the Coder agent.
- A persistent Docker volume mounted at `/home/coder`, independent of container recreation.
- [code-server](https://registry.coder.com/modules/coder/code-server) for browser-based VS Code access.
- [mux](https://registry.coder.com/modules/coder/mux) for running and monitoring multiple AI agent sessions in parallel, each in its own isolated workspace, with a browser UI.
- [opencode](https://opencode.ai) CLI, installed on first boot via `run.sh`, with its MCP config pointed at the self-hosted Supabase MCP endpoint so the agent can query the database directly.
- [supabase/agent-skills](https://github.com/supabase/agent-skills) installed via `npx skills add supabase/agent-skills` so the agent follows Supabase's documented best practices instead of guessing.

## Resource limits and hardening

- CPU (`cpus`) and memory (`memory` / `memory_swap`) are hard Docker limits, selectable at workspace creation via the `cpu` and `memory` parameters. No swap overflow beyond the memory limit.
- Container runs unprivileged (`privileged = false`), as uid/gid `1000:1000` (non-root), with all Linux capabilities dropped (`capabilities.drop = ["ALL"]`) and `no-new-privileges` set.

## Configuration

- `supabase_mcp_url` is a template variable (not a workspace parameter), so it's set once via **Template Settings > Variables** in the Coder GUI (or `--var` on first push) and reused on every subsequent `coder templates push` without re-specifying it.
- `opencode_version` pins the opencode CLI version installed in `run.sh` (defaults to `1.18.18`), so workspace rebuilds don't silently pick up a new release. Bump it the same way as `supabase_mcp_url` to upgrade.
- The `mux` module's `install_version` is pinned to `0.28.2` directly in `main.tf` (its default is `"next"`, a moving target) — bump by editing the module block.

## Prerequisites

- Docker available on the Coder provisioner host (this repo assumes the Coder server itself, via `/var/run/docker.sock`, per `/opt/coder/docker-compose.yml`).
- The self-hosted Supabase MCP endpoint reachable from inside the workspace container.

## Pushing this template

From the repo root:

```bash
coder templates push docker-dev-mux -d Coder-templates/docker-dev-mux -y
```
