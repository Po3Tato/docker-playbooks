# Coder Docker Workspace Template

Coder template that provisions a Docker container as a workspace on this host. Used to spin up an isolated, resource-limited dev environment with code-server (browser IDE) and the opencode CLI coding agent preconfigured against a self-hosted Supabase MCP endpoint.

## What it provisions

- A `codercom/example-node:ubuntu` container (Node.js preinstalled) as the workspace, connected to the Coder agent.
- A persistent Docker volume mounted at `/home/coder`, independent of container recreation.
- [code-server](https://registry.coder.com/modules/coder/code-server) for browser-based VS Code access.
- [opencode](https://opencode.ai) CLI, installed on first boot via `run.sh`, with its MCP config pointed at the self-hosted Supabase MCP endpoint so the agent can query the database directly.
- [supabase/agent-skills](https://github.com/supabase/agent-skills) installed via `npx skills add supabase/agent-skills` so the agent follows Supabase's documented best practices instead of guessing.

## Resource limits and hardening

- CPU (`cpus`) and memory (`memory` / `memory_swap`) are hard Docker limits, selectable at workspace creation via the `cpu` and `memory` parameters. No swap overflow beyond the memory limit.
- Container runs unprivileged (`privileged = false`), as uid/gid `1000:1000` (non-root), with all Linux capabilities dropped (`capabilities.drop = ["ALL"]`) and `no-new-privileges` set.

## Configuration

`supabase_mcp_url` is a template variable (not a workspace parameter), so it's set once via **Template Settings > Variables** in the Coder GUI (or `--var` on first push) and reused on every subsequent `coder templates push` without re-specifying it.

## Prerequisites

- Docker available on the Coder provisioner host (this repo assumes the Coder server itself, via `/var/run/docker.sock`, per `/opt/coder/docker-compose.yml`).
- The self-hosted Supabase MCP endpoint reachable from inside the workspace container.

## Pushing this template

From the repo root:

```bash
coder templates push coder-templates -d Coder-templates -y
```
