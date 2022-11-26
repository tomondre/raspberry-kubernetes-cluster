resource "kubernetes_cron_job" "cron_job" {
  metadata {
    name = var.name
  }
  spec {
    schedule           = var.cron
    concurrency_policy = "Replace"
    job_template {
      metadata {}
      spec {
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name  = var.name
              image = "${var.image_url}:${var.image_tag}"
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