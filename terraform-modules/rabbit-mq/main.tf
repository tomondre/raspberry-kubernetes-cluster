terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["rabbit-mq"]
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}

locals {
  service_name = "rabbitmq"
  namespace = "default"
}

module "deployment" {
  source = "../reusable-modules/deployment"
  image_tag = "management"
  image_url = "rabbitmq"
  service_name = local.service_name
  port = 15672
  namespace = local.namespace
}

module "service" {
  source = "../reusable-modules/service"
  container_port = 5672
  namespace = local.namespace
  service_name = local.service_name
  service_port = 5672
}

module "email_rabbitmq_consumer" {
  source            = "../reusable-modules/deployment"
  image_tag         = "6"
  image_url         = "tomondre/email-rabbitmq-consumer"
  service_name      = "email-rabbitmq-consumer"
  env = var.env
}