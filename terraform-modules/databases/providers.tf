terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["databases"]
    }
  }
}

provider "kubernetes" {
  config_path = var.kubernetes_config_file_path
}
