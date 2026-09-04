variable "docker_socket" {
  default     = ""
  description = "(Optional) Docker socket URI, e.g. tcp://docker-host:2375. Leave empty to use the local socket."
  type        = string
}

variable "cpu" {
  default     = 2
  description = "CPU cores allocated to the workspace (host has 4 cores)"
  type        = number

  validation {
    condition     = var.cpu >= 1 && var.cpu <= 4
    error_message = "CPU cores must be between 1 and 4."
  }
}

variable "memory" {
  default     = 4096
  description = "Memory allocated to the workspace in MB (host has 8 GB)"
  type        = number

  validation {
    condition     = var.memory >= 512 && var.memory <= 8192
    error_message = "Memory must be between 512 and 8192 MB."
  }
}
