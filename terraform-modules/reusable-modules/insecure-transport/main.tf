terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubernetes_config_file_path
}


resource "kubectl_manifest" "server_transport_insecure_skip_verify" {
  yaml_body = <<EOF
apiVersion: traefik.containo.us/v1alpha1
kind: ServersTransport
metadata:
  name: ${var.transport_name}
  namespace: ${var.transport_namespace}

spec:
  insecureSkipVerify: true
EOF

}
