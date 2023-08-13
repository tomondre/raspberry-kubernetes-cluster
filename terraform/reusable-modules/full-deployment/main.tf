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
  depends_on     = [module.deployment]
  annotations    = var.annotations
}

module "ingress" {
  source            = "../ingress"
  host_name         = local.host_name
  service_name      = var.service_name
  service_namespace = var.namespace
  service_port      = local.service_port
  depends_on        = [module.dns_record]
  scheme            = var.scheme
}

module "deployment" {
    source                            = "../deployment"
    health_check_path                 = var.health_check_path
    image_tag                         = var.image_tag
    image_url                         = var.image_url
    service_name                      = var.service_name
    port                              = var.port
    namespace                         = var.namespace
    replicas                          = var.replicas
    env                               = var.env
    cpu_limit                         = var.cpu_limit
    cpu_request                       = var.cpu_request
    memory_limit                      = var.memory_limit
    memory_request                    = var.memory_request
    health_check_initial_delay_seconds= var.health_check_initial_delay_seconds
}
