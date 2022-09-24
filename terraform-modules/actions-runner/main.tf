#https://github.com/actions-runner-controller/actions-runner-controller/blob/master/QuickStartGuide.md
terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["actions-runner"]
    }
  }
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}

module "celebrator_3000" {
  source = "../reusable-modules/runner-deployment"
  repo_name = "celebrator-3000"
}