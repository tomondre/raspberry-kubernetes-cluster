resource "kubernetes_service" "service" {
  metadata {
    name        = var.service_name
    namespace   = var.namespace
    annotations = var.annotations
    labels = {
      app = var.service_name
      release = "kube-prometheus-stackr"
    }
  }
  spec {
    selector = {
      app = var.service_name
    }
    port {
      port        = var.service_port
      target_port = var.container_port
    }
    type = "ClusterIP"
  }
}
