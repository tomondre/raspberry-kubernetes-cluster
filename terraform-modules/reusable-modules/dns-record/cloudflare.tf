terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

resource "cloudflare_record" "domain_record" {
  name    = var.record_host
  type    = "A"
  zone_id = data.cloudflare_zone.zone.id
  value   = var.router_ip
  proxied = true
}

data "cloudflare_zone" "zone" {
  name = local.zone_name
}