resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    labels    = {
      app = var.service_name
      release : "kube-prometheus-stackr"
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
            name           = var.port_name
          }

          dynamic "port" {
            for_each = var.additional_port
            content {
              name           = port.value.name
              container_port = port.value.container_port
              protocol       = port.value.protocol
            }
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
          command = var.command
          args    = var.args

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