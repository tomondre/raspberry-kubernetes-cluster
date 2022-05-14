terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["namespaces"]
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}

//Example
#module "cms" {
#  source = "../reusable-modules/namespace"
#  name   = "cms"
#}