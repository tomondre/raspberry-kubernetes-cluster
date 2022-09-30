resource "kubernetes_manifest" "traefik-ingress-route" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRoute"
    metadata   = {
      name      = var.service_name
      namespace = var.service_namespace
    }
    spec = {
      entryPoints = var.entrypoint
      routes      = [
        {
          kind     = "Rule"
          match    = "Host(`${var.host_name}.tomondre.com`)"
          services = [
            {
              name             = var.service_name
              namespace        = var.service_namespace
              port             = var.service_port
              serversTransport = var.server_transport
              scheme           = var.scheme
            }
          ]
        }
      ]
    }
  }
}