terraform {

    required_version = ">= 1.6.0"

    required_providers {
        proxmox = {
            source = "Telmate/proxmox" # module being used make sure you check on updates https://registry.terraform.io/providers/Telmate/proxmox/latest
            version = "2.9.14" # current version as of 11/05/2023
        }
    }

}

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

provider "proxmox" {

    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret

    # (Optional) Skip TLS Verification if you get that beautiful warning when navigating to proxmox gui on browser
    pm_tls_insecure = true

}