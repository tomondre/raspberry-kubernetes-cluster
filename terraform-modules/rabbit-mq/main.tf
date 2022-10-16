terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
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
  additional_port = [{
    name = "metrics"
    container_port = "15692"
    protocol = "TCP"
  }]
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

resource "kubectl_manifest" "service_monitor" {
  yaml_body = <<EOF
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  labels:
    app: rabbitmq
    release: kube-prometheus-stackr
  name: rabbitmq-monitor
  namespace: default
spec:
  podMetricsEndpoints:
  - path: /metrics
    port: metrics
  namespaceSelector:
    matchNames:
      - default
  selector:
    matchLabels:
      app: rabbitmq
EOF
  depends_on = [module.service]
}