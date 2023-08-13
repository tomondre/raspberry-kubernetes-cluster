
resource "kubernetes_secret" "secret" {
  metadata {
    name = var.name
    namespace = var.namespace
  }

  type = var.type
  data = var.data
}