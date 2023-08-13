resource "helm_release" "mysql_exporter" {
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
  depends_on = [helm_release.mysql_exporter]
}