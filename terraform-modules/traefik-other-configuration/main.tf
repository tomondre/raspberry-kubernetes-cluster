terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["traefik-config"]
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
  name: insecure-skip-transport
  namespace: default

spec:
  insecureSkipVerify: true
EOF

}
