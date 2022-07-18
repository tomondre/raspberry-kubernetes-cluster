terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["cloud"]
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_token = var.cloudflare_api_token
}

provider "kubernetes" {
  config_path = var.kubernetes_config_file_path
}

