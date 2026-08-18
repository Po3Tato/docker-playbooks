terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "~> 2.5"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}
provider "coder" {}

variable "supabase_mcp_url" {
  type        = string
  description = "Self-hosted Supabase MCP endpoint consumed by the opencode CLI agent. Set via Template Settings > Variables or --var on first push; not defaulted here to keep the endpoint out of the repo."
}

data "coder_workspace" "me" {}
data "coder_workspace_owner" "me" {}
data "coder_provisioner" "me" {}

locals {
  cpu_options = {
    "2 cores" = "2"
    "4 cores" = "4"
    "6 cores" = "6"
  }
  memory_options = {
    "4 GB"  = "4096"
    "8 GB"  = "8192"
    "16 GB" = "16384"
  }
  username = data.coder_workspace_owner.me.name
}

data "coder_parameter" "cpu" {
  name         = "cpu"
  display_name = "CPU"
  description  = "Number of CPU cores, enforced as a hard limit on the container."
  type         = "string"
  default      = "2"
  icon         = "/icon/memory.svg"
  mutable      = true
  order        = 1

  dynamic "option" {
    for_each = local.cpu_options
    content {
      name  = option.key
      value = option.value
    }
  }
}

data "coder_parameter" "memory" {
  name         = "memory"
  display_name = "Memory"
  description  = "Memory limit in MB, enforced as a hard limit on the container (no swap overflow)."
  type         = "string"
  default      = "4096"
  icon         = "/icon/memory.svg"
  mutable      = true
  order        = 2

  dynamic "option" {
    for_each = local.memory_options
    content {
      name  = option.key
      value = option.value
    }
  }
}

resource "coder_agent" "main" {
  arch           = data.coder_provisioner.me.arch
  os             = "linux"
  startup_script = file("${path.module}/run.sh")

  env = {
    SUPABASE_MCP_URL = var.supabase_mcp_url
  }

  metadata {
    display_name = "CPU Usage"
    key          = "cpu"
    script       = "coder stat cpu"
    interval     = 10
    timeout      = 1
  }

  metadata {
    display_name = "RAM Usage"
    key          = "ram"
    script       = "coder stat mem"
    interval     = 10
    timeout      = 1
  }
}

module "code-server" {
  source    = "registry.coder.com/coder/code-server/coder"
  version   = "~> 1.0"
  agent_id  = coder_agent.main.id
  folder    = "/home/coder"
  order     = 1
  subdomain = false
}

resource "docker_volume" "home" {
  name = "coder-${local.username}-${data.coder_workspace.me.name}-home"

  lifecycle {
    ignore_changes = all
  }
}

resource "docker_container" "workspace" {
  count      = data.coder_workspace.me.start_count
  image      = "codercom/example-node:ubuntu"
  name       = "coder-${local.username}-${data.coder_workspace.me.name}"
  hostname   = data.coder_workspace.me.name
  entrypoint = ["sh", "-c", coder_agent.main.init_script]
  env        = ["CODER_AGENT_TOKEN=${coder_agent.main.token}"]

  user        = "1000:1000"
  privileged  = false
  cpus        = data.coder_parameter.cpu.value
  memory      = tonumber(data.coder_parameter.memory.value)
  memory_swap = tonumber(data.coder_parameter.memory.value)

  security_opts = ["no-new-privileges:true"]

  capabilities {
    drop = ["ALL"]
  }

  volumes {
    container_path = "/home/coder"
    volume_name     = docker_volume.home.name
    read_only       = false
  }

  labels {
    label = "coder.owner"
    value = data.coder_workspace_owner.me.name
  }

  labels {
    label = "coder.workspace_id"
    value = data.coder_workspace.me.id
  }
}

resource "coder_metadata" "workspace_info" {
  count       = data.coder_workspace.me.start_count
  resource_id = docker_container.workspace[0].id

  item {
    key   = "cpu"
    value = "${data.coder_parameter.cpu.value} cores"
  }

  item {
    key   = "memory"
    value = "${data.coder_parameter.memory.value} MB"
  }

  item {
    key   = "image"
    value = "codercom/example-node:ubuntu"
  }
}
