terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["cron-jobs"]
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\PC1\\.kube\\config"
}

resource "kubernetes_cron_job_v1" "celebrations_email" {
  metadata {
    name = var.name
  }
  spec {
    schedule = var.cron
    job_template {
      metadata {}
      spec {
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name  = var.name
              image = "${var.image}:${var.tag}"
              dynamic "env" {
                for_each = var.env
                content {
                  name  = env.key
                  value = env.value
                }
              }
            }
          }
        }
      }
    }
  }
}