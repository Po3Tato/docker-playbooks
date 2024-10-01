terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token # do_token is a variable that is stored in the digitalocean.auto.tfvars file.
}

resource "digitalocean_droplet" "<server refrence - name>" {
  image     = "<image name>" # For this section refer to https://slugs.do-api.dev/ 
  name      = "<server name>"
  region    = "<region>"
  size      = "<type of droplet size>"
  monitoring = true # Optional but you cal cli and get info on system with this true
  # doctl -t dop_v1_token compute ssh-key list. To get the token associated with the ssh key you have on digitalocean.
  ssh_keys  = [<ssh_key ID token>]
}

resource "digitalocean_project_resources" "Project name" {
  project = "project_id" # See https://docs.digitalocean.com/reference/api/api-reference/#operation/projects_list
  resources = [
    digitalocean_droplet.<server refrence - name>.urn
  ]
}
