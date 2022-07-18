locals {
  traefik_service_name   = "traefik"
  traefik_whitelist_name = "traefik-whitelist-middleware"
  traefik_namespace      = "kube-system"
}

module "traefik_dashboard_dns" {
  source    = "../reusable-modules/dns-record"
  host_name = local.traefik_service_name
  namespace = "kube-system"
}

resource "kubernetes_manifest" "traefik_ingress_route" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRoute"
    metadata   = {
      name      = local.traefik_service_name
      namespace = local.traefik_namespace
    }
    spec = {
      entryPoints = ["websecure", "web"]
      routes      = [
        {
          kind        = "Rule"
          match       = "Host(`${local.traefik_service_name}.tomondre.com`) "
          middlewares = [
            {
              name      = "auth-middleware"
              namespace = local.traefik_namespace
            },
#            {
#              name      = local.traefik_whitelist_name
#              namespace = local.traefik_namespace
#            }
          ]
          services = [
            {
              name = "api@internal"
              kind = "TraefikService"
            }
          ]
        }
      ]
#    , tls = {
#        secretName = "${local.traefik_service_name}-secret"
#      }
    }
  }
}

resource "kubernetes_manifest" "traefik-auth-middleware" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "Middleware"
    metadata   = {
      name      = "auth-middleware"
      namespace = local.traefik_namespace
    }
    spec = {
      basicAuth = {
        #        SECRET NEEDS TO BE ALREADY CREATED IN KUBERNETES
        secret = "auth-secret"
      }
    }
  }
#  depends_on = [module.traefik_whitelist_middleware]
}

#module "traefik_whitelist_middleware" {
#  source        = "../reusable-modules/whitelist-middleware"
#  name          = local.traefik_whitelist_name
#  whitelist_ips = var.whitelist_ips
#  namespace     = local.traefik_namespace
#}