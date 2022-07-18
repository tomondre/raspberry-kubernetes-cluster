locals {
  service_name = "tomondre-${var.name}-service"
  service_port = 8080
}

module "dns_record" {
  source = "../dns-record"
  host_name = var.name
  namespace = var.namespace
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
  host_name = var.name
  service_name = local.service_name
  service_namespace = var.namespace
  service_port = local.service_port
  depends_on = [module.dns_record]
}