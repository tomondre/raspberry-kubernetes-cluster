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
  type    = "CNAME"
  zone_id = data.cloudflare_zone.zone.id
  value   = var.tunnel_dns
  proxied = true
}

data "cloudflare_zone" "zone" {
  name = local.zone_name
}