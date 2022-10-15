resource "helm_release" "cloudflare_monitor" {
  chart = "cloudflare-exporter"
  name  = "cloudflare-exporter"
  repository = "https://lablabs.github.io/cloudflare-exporter/"
  namespace = "monitoring"

  set {
    name  = "secretRef"
    value = "cloudflare-credentials"
  }
#  set {
#    name  = "image.repository"
#    value = "docker.io/lablabs/cludflare_exporter"
#  }
  set {
    name  = "image.tag"
    value = "0.0.13"
  }

  depends_on = [kubernetes_secret.cloudflare_credentials]
}

resource "kubernetes_secret" "cloudflare_credentials" {
  metadata {
    namespace = "monitoring"
    name = "cloudflare-credentials"
  }
  data = {
    CF_API_TOKEN = var.cloudflare_token
    }
}

resource "kubectl_manifest" "cloudflare_monitor" {
  yaml_body = <<EOF
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    release: kube-prometheus-stackr
  name: cloudflare-exporter-monitor
  namespace: monitoring
spec:
  endpoints:
  - path: /metrics
    port: http
  namespaceSelector:
    matchNames:
    - monitoring
  selector:
    matchLabels:
      app.kubernetes.io/name: cloudflare-exporter
EOF
  depends_on = [helm_release.cloudflare_monitor]
}