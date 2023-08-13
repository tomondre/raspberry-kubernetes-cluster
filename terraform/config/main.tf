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
      dashboard: false
    pilot:
      token: ${var.pilot_traefik_token}
    logs:
      access:
        enabled: true
    experimental:
      plugins:
        traefik-real-ip:
          moduleName: github.com/soulbalz/traefik-real-ip
          version: v1.0.3
    accessLog:
      filePath: /var/log/traefik.log
      format: json
      fields:
        headers:
          defaultMode: keep
EOF
}

resource "kubectl_manifest" "traefik-real-ip-middleware" {
  yaml_body = <<-EOF
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: traefik-real-ip
  namespace: default
spec:
  plugin:
    traefik-real-ip:
      excludenets:
        - "127.0.0.1"
EOF
}

#<<-EOF
#accessLog:
#      filePath: "/var/log/traefik.log"
#      format: json
#      fields:
#        headers:
#          defaultMode: keep
#
#EOF