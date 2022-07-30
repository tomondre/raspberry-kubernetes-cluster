locals {
  service_port = 8080
  host_name    = var.host_name == "" ? var.service_name : var.host_name
}

module "dns_record" {
  source    = "../dns-record"
  host_name = local.host_name
  namespace = var.namespace
}

module "service" {
  source         = "../service"
  container_port = var.port
  service_name   = var.service_name
  service_port   = local.service_port
  namespace      = var.namespace
}

module "ingress" {
  source            = "../ingress"
  host_name         = local.host_name
  service_name      = var.service_name
  service_namespace = var.namespace
  service_port      = local.service_port
  depends_on        = [module.dns_record]
}