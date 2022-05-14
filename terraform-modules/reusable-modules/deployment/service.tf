resource "kubernetes_service" "service" {
  metadata {
    name = local.service_name
  }
  spec {
    selector = {
      app = local.service_name
    }
    port {
      port        = local.service_port
      target_port = var.port
    }
    type = "ClusterIP"
  }
}