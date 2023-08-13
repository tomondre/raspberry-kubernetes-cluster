terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["environment"]
    }
  }
}

locals {
  host = "cloud.tomondre.com"
  service_name = nextcloud
}

#resource "kubernetes_manifest" "traefik-ingress-route" {
#  manifest = {
#    apiVersion = "traefik.containo.us/v1alpha1"
#    kind       = "IngressRoute"
#    metadata   = {
#      name      = local.service_name
#    }
#    spec = {
#      entryPoints = ["websecure", "web"]
#      routes      = [
#        {
#          kind     = "Rule"
#          match    = "Host(`${local.host}.tomondre.com`)"
#          services = [
#            {
#              name             = var.service_name
#              namespace        = var.service_namespace
#              port             = var.service_port
#              serversTransport = var.server_transport
#              scheme           = var.scheme
#            }
#          ]
#        }
#      ]
#    }
#  }
#}
