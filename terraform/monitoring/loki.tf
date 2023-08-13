resource "helm_release" "loki" {
  name = "loki"
  namespace = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart = "loki-stack"
  set {
    name  = "promtail.config.client.url"
    value = "http://loki.monitoring.svc.cluster.local:3100/loki/api/v1/push"
  }
}