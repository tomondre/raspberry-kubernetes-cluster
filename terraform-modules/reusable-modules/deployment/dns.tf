module "dns_record" {
  source = "../dns-record"
  service_name = var.name
  router_ip = var.server_ip
}