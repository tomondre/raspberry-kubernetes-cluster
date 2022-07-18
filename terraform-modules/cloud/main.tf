locals {
  app            = "cloud"
  namespace      = "default"
  container_port = 443
  mount_path     = "/mnt/disk/cloud-data"
  volume_name    = "cloud-storage"
}

module "volume" {
  source   = "../reusable-modules/volume-claim"
  app_name = local.app
  storage  = "256Mi"
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = local.app
    namespace = local.namespace
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
          image = "lscr.io/linuxserver/nextcloud:latest"
          name  = local.app
          env {
            name = "PUID"
            value = "1000"
          }
          env {
            name = "PGID"
            value = "1000"
          }
          port {
            container_port = local.container_port
          }
          volume_mount {
            mount_path = local.mount_path
            name       = local.volume_name
          }
        }
        volume {
          name = local.volume_name
          persistent_volume_claim {
            claim_name = module.volume.name
          }
        }
      }
    }
  }
}

module "cloud-service" {
  source = "../reusable-modules/service"
  container_port = local.container_port
  namespace = local.namespace
  service_name = local.app
}

module "cloud-ingress" {
  source = "../reusable-modules/ingress"
  host_name = local.app
  service_name = local.app
  service_namespace = local.namespace
  service_port = 8080
}

module "record" {
  source = "../reusable-modules/dns-record"
  host_name = local.app
}