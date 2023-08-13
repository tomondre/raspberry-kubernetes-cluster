locals {
  name = "${var.app_name}-volume-claim"
}

resource "kubernetes_persistent_volume_claim" "claim" {
  metadata {
    name   = local.name
    labels = {
      app = var.app_name
    }
  }
  spec {
    access_modes = var.access_modes

    resources {
      requests = {
        storage = var.storage
      }
    }
    storage_class_name = var.storage_class
  }
}
