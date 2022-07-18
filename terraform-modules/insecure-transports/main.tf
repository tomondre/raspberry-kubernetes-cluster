terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["insecure-transports"]
    }
  }
}

module "default_transport" {
  source = "../reusable-modules/insecure-transport"
  kubernetes_config_file_path = var.kubernetes_config_file_path
  transport_namespace         = "default"
}

module "kubernetes_dashboard_transport" {
  source = "../reusable-modules/insecure-transport"
  kubernetes_config_file_path = var.kubernetes_config_file_path
  transport_namespace         = "kubernetes-dashboard"
}