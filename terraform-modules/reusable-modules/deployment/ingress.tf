resource "kubernetes_manifest" "traefik-ingress-route" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRoute"
    metadata   = {
      name      = local.service_name
      namespace = var.namespace
    }
    spec = {
      entryPoints = ["web"]
      routes      = [
        {
          kind     = "Rule"
          match    = "Host(`${module.dns_record.fqdn}`)"
          services = [
            {
              name      = local.service_name
              namespace = var.namespace
              port      = local.service_port
            }
          ]
        }
      ]
    }
  }
}