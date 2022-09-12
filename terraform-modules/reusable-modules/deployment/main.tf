resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    labels    = {
      app = var.service_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.service_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.service_name
        }
      }

      spec {
        container {
          image = "${var.image_url}:${var.image_tag}"
          name  = var.service_name

          port {
            container_port = var.port
          }

          dynamic "env" {
            for_each = var.env
            content {
              name  = env.key
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

          dynamic liveness_probe {
            for_each = var.health_check_path != ""? [1] : []
            content {
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
}