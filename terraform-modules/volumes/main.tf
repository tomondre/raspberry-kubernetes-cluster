#resource "kubernetes_persistent_volume" "example" {
#  metadata {
#    name = "hdd-test-volume"
#  }
#  spec {
#    capacity = {
#      storage = "2Gi"
#    }
#    storage_class_name = "local-path"
#    persistent_volume_reclaim_policy = "Retain"
#    access_modes = ["ReadWriteMany"]
#    persistent_volume_source {
#      vsphere_volume {
#        volume_path = "/mnt/disk/storage"
#      }
#    }
#    node_affinity {
#      required {
#        node_selector_term {
#          match_expressions {
#            key      = "  "
#            operator = ""
#          }
#        }
#      }
#    }
#  }
#}