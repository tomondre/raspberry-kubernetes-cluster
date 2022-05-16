terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["dashboards"]
    }
  }
}

#KUBERNETES DASHBOARD
locals {
  dashboard_host = "dashboard"
}

module "kubernetes_dashboard_dns" {
  source    = "../reusable-modules/dns-record"
  router_ip = var.server_ip
  host_name = local.dashboard_host
  namespace = "kubernetes-dashboard"
}

module "kubernetes_dashboard_ingress" {
  source            = "../reusable-modules/ingress"
  host_name         = local.dashboard_host
  service_name      = "kubernetes-dashboard"
  service_namespace = "kubernetes-dashboard"
  service_port      = 443
}

#TRAEFIK DASHBOARD
locals {
  traefik_service_name = "traefik"
  namespace            = "kube-system"
}

module "traefik_dashboard_dns" {
  source    = "../reusable-modules/dns-record"
  router_ip = var.server_ip
  host_name = local.traefik_service_name
  namespace = "kube-system"
}

resource "kubernetes_manifest" "traefik_ingress_route" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRoute"
    metadata   = {
      name      = local.traefik_service_name
      namespace = local.namespace
    }
    spec = {
      entryPoints = ["websecure"]
      routes      = [
        {
          kind        = "Rule"
          match       = "Host(`${local.traefik_service_name}.tomondre.com`)"
          middlewares = [
            {
              name      = "auth-middleware"
              namespace = local.namespace
            }
          ]
          services = [
            {
              name = "api@internal"
              kind = "TraefikService"
            }
          ]
        }
      ],
      tls = {
        secretName = "${local.traefik_service_name}-secret"
      }
    }
  }
}

resource "kubernetes_manifest" "traefik-auth-middleware" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "Middleware"
    metadata   = {
      name      = "auth-middleware"
      namespace = local.namespace
    }
    spec = {
      basicAuth = {
        #        SECRET NEEDS TO BE ALREADY CREATED IN KUBERNETES
        secret = "auth-secret"
      }
    }
  }
}