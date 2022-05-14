resource "kubernetes_deployment" "deployment" {
  metadata {
    name = local.service_name
    namespace = var.namespace
    labels = {
      app = local.service_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = local.service_name
      }
    }

    template {
      metadata {
        labels = {
          app = local.service_name
        }
      }

      spec {
        container {
          image = "${var.image_url}:${var.image_tag}"
          name  = local.service_name

          port {
            container_port = var.port
          }

          dynamic "env" {
            for_each = var.env
            content {
              name = env.key
              value = env.value
            }
          }

          resources {
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
          }

          liveness_probe {
            http_get {
              path = var.health_check_path
              port = var.port
            }

            initial_delay_seconds = 5
            period_seconds        = 30
          }
        }
      }
    }
  }
}