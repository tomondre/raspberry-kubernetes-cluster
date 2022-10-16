terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["monitoring"]
    }
  }
}

locals {
  namespace = "monitoring"
  host = "grafana"
}

resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name = local.namespace
  }
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = local.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  set {
    name  = "grafana.useStatefulSet"
    value = "true"
  }
  set {
    name  = "grafana.persistence.storageClassName"
    value = "local-path"
  }
  set {
    name  = "grafana.persistence.size"
    value = "5Gi"
  }
  set {
    name  = "grafana.persistence.enabled"
    value = "true"
  }
}

module "record" {
  source = "../reusable-modules/dns-record"
  host_name = local.host
}

module "ingress" {
  source = "../reusable-modules/ingress"
  host_name = local.host
  service_name = "kube-prometheus-stackr-grafana"
  service_namespace = "monitoring"
  service_port = "80"
  server_transport = null
}

resource "kubectl_manifest" "traefik_config" {
  yaml_body = <<EOF
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  labels:
    release: kube-prometheus-stackr
    app.kubernetes.io/name: traefik
  name: traefik-pod-monitor
  namespace: kube-system
spec:
  namespaceSelector:
    matchNames:
      - kube-system
  podMetricsEndpoints:
    - port: metrics
      path: /metrics
      interval: 15s
  selector:
    matchLabels:
      release: kube-prometheus-stackr
      app.kubernetes.io/name: traefik
EOF
}

resource "helm_release" "mysq_exporter" {
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "prometheus-mysql-exporter"
  name  = "prometheus-mysql-exporter"
  namespace = local.namespace
  set {
    name  = "mysql.user"
    value = var.mysql_user
  }
  set {
    name  = "mysql.pass"
    value = var.mysql_password
  }
  set {
    name  = "mysql.host"
    value = var.mysql_host
  }
  set {
    name  = "mysql.port"
    value = "3306"
  }
}

resource "kubectl_manifest" "service_monitor" {
  yaml_body = <<EOF
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    release: kube-prometheus-stackr
  name: kube-prometheus-stackr-mysql
  namespace: monitoring
spec:
  endpoints:
  - path: /metrics
    port: mysql-exporter
  namespaceSelector:
    matchNames:
    - monitoring
  selector:
    matchLabels:
      app.kubernetes.io/name: prometheus-mysql-exporter
EOF
  depends_on = [helm_release.mysq_exporter]
}