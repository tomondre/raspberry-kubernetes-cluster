resource "kubernetes_namespace" "namespace" {
  metadata {
    labels = {
      owner = "terraform"
    }

    name = var.name
  }
}