terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

resource "cloudflare_record" "domain_record" {
  name    = var.host_name
  type    = "A"
  zone_id = data.cloudflare_zone.zone.id
  value   = var.router_ip
  proxied = true
}

data "cloudflare_zone" "zone" {
  name = local.zone_name
}

#TODO Maybe we need only one dns challenge for the whole dns?
resource "kubectl_manifest" "certificate" {
  yaml_body = <<-EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cert-${var.host_name}
  namespace: ${var.namespace}
spec:
  secretName: ${var.host_name}-secret
  issuerRef:
    name: letsencrypt
    kind: ClusterIssuer
  commonName: '${var.host_name}.tomondre.com'
  dnsNames:
  - "${var.host_name}.tomondre.com"
EOF
}