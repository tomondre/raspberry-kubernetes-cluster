locals {
  app        = "maria-db"
}

resource "kubernetes_deployment" "maria_db" {
  metadata {
    name      = local.app
    namespace = "default"
    labels    = {
      app = local.app
    }
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        app = local.app
      }
    }
    template {
      metadata {
        labels = {
          app = local.app
        }
      }
      spec {
        container {
          name  = "mariadb"
          image = "mariadb:latest"
          env {
            name  = "MARIADB_DATABASE"
            value = var.database_name
          }
          env {
            name  = "MARIADB_ROOT_PASSWORD"
            value = var.database_password
          }
          volume_mount {
            mount_path = "/mnt/disk/maria-db"
            name       = "db-storage"
          }
        }
        volume {
          name = "db-storage"
          persistent_volume_claim {
            claim_name = module.volume_claim.name
          }
        }
      }
    }
  }
}

module "volume_claim" {
  source = "../reusable-modules/volume-claim"
  app_name = local.app
  storage = "256Mi"
}

module "service" {
  source         = "../reusable-modules/service"
  container_port = 3306
  namespace      = "default"
  service_name   = local.app
}