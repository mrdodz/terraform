terraform {

  # required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~> 17.6.1"
    }
  }

  backend "http" {

  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure = true
}

# provider "gitlab" {
#   base_url = "https://example.com/api/v4"
#   token = var.gitlab_token
# }