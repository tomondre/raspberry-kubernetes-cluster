terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["volumes"]
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}
