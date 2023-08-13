terraform {
  cloud {
    organization = "raspberry-kubernetes-cluster"

    workspaces {
      tags = ["tls"]
    }
  }
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

resource "kubectl_manifest" "issuer" {
    yaml_body = <<-EOF
  apiVersion: cert-manager.io/v1
  kind: ClusterIssuer
  metadata:
    name: letsencrypt
    namespace: cert-manager
  spec:
    acme:
      email: ${var.email}
      server: https://acme-v02.api.letsencrypt.org/directory
      privateKeySecretRef:
        name: le-issuer-acct-key
      solvers:
      - dns01:
          cloudflare:
            email: ${var.email}
            apiTokenSecretRef:
              name: cloudflare-api-token-secret
              key: api-token
        selector:
          dnsZones:
          - 'tomondre.com'
          - '*.tomondre.com'
  EOF
  }

resource "kubectl_manifest" "token" {
  yaml_body = <<-EOF
apiVersion: v1
kind: Secret
metadata:
  name: cloudflare-api-token-secret
  namespace: cert-manager
type: Opaque
stringData:
  api-token: ${var.cloudflare_api_token}
EOF

  depends_on = [kubectl_manifest.issuer]
}

#Used references:
#https://stackoverflow.com/questions/63346728/issuing-certificate-as-secret-does-not-exist
#https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/

//Certificate example
#resource "kubectl_manifest" "cert" {
#  yaml_body = <<-EOF
#apiVersion: cert-manager.io/v1
#kind: Certificate
#metadata:
#  name: wildcard-cert
#  namespace: default
#spec:
#  secretName: cloudflare-api-token-secret
#  issuerRef:
#    name: letsencrypt
#    kind: ClusterIssuer
#  commonName: '*.tomondre.com'
#  dnsNames:
#  - "tomondre.com"
#  - "*.tomondre.com"
#EOF
#}

#--------------------JUNK--------------------

#STAGING SERVER
#resource "kubectl_manifest" "dns" {
#  yaml_body = <<-EOF
#apiVersion: cert-manager.io/v1
#kind: ClusterIssuer
#metadata:
#  name: letsencrypt-stg
#  namespace: cert-manager
#spec:
#  acme:
#    email:
#    server: https://acme-staging-v02.api.letsencrypt.org/directory
#    privateKeySecretRef:
#      name: le-issuer-acct-key
#    solvers:
#    - dns01:
#        cloudflare:
#          email:
#          apiTokenSecretRef:
#            name: cloudflare-api-token-secret
#            key: api-token
#      selector:
#        dnsZones:
#        - 'tomondre.com'
#        - '*.tomondre.com'
#EOF
#}