locals {
  service_name = "tomondre-${var.name}-service"
  service_port = 8080
}

module "dns_record" {
  source = "../dns-record"
  record_host = var.name
  router_ip = var.server_ip
}

module "service" {
  source = "../service"
  container_port = var.port
  service_name = local.service_name
  service_port = local.service_port
  namespace = var.namespace
}

module "ingress" {
  source = "../ingress"
  ingress_host_fqdn = module.dns_record.fqdn
  service_name = local.service_name
  service_namespace = var.namespace
  service_port = local.service_port
}