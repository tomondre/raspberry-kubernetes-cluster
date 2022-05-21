terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["config"]
    }
  }
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

#Refer to: https://traefik.io/traefik-pilot/
resource "kubectl_manifest" "pilot-traefik-token" {
  yaml_body = <<-EOF
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: traefik
  namespace: kube-system
spec:
  valuesContent: |-
    api:
      dashboard: true
    pilot:
      token: "${var.pilot_traefik_token}"
EOF
}