terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["secrets"]
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}


module "docker_hub" {
  source = "../reusable-modules/secret"
  data   = {
    username = var.docker_hub_username
    password = var.docker_hub_token
  }
  name      = "docker-hub"
  namespace = "actions-runner-system"
}