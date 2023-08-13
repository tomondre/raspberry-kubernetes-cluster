terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["monitoring"]
    }
  }
}

locals {
  namespace = "monitoring"
  host = "grafana"
  scrape_interval = "1m"
}

resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = local.namespace
  }
}