terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["deployments"]
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
