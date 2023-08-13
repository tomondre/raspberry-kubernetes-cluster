terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["environment"]
    }
  }
}

locals {
  host = "cloud.tomondre.com"
  service_name = nextcloud
}

resource "helm_release" "cloud_helm_release" {
  chart = "nextcloud"
  name  = "nextcloud"
  repository = "https://nextcloud.github.io/helm/"

  set {
    name  = "nextcloud.host"
    value = "https://${local.host}"
  }

  set {
    name  = "nextcloud.configs.s3.config.php"
    value = <<EOF
  <?php
  $CONFIG = array (
    'objectstore' => array(
    'class' => '\\OC\\Files\\ObjectStore\\S3',
    'arguments' => array(
    'bucket'     => 'my-bucket',
    'autocreate' => true,
    'key'        => '${var.nextcloud_aws_access_key}',
    'secret'     => '${var.nextcloud_aws_secret_key}',
    'region'     => '${var.nextcloud_aws_region}',
    'use_ssl'    => true
    )
  )
  );
EOF
  }
}

#resource "kubernetes_manifest" "traefik-ingress-route" {
#  manifest = {
#    apiVersion = "traefik.containo.us/v1alpha1"
#    kind       = "IngressRoute"
#    metadata   = {
#      name      = local.service_name
#    }
#    spec = {
#      entryPoints = ["websecure", "web"]
#      routes      = [
#        {
#          kind     = "Rule"
#          match    = "Host(`${local.host}.tomondre.com`)"
#          services = [
#            {
#              name             = var.service_name
#              namespace        = var.service_namespace
#              port             = var.service_port
#              serversTransport = var.server_transport
#              scheme           = var.scheme
#            }
#          ]
#        }
#      ]
#    }
#  }
#}
