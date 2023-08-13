locals {
  dashboard_host = "kubernetes"
  transport_name = "kubernetes-dashboard-transport"
  kubernetes_namespace = "kubernetes-dashboard"
  kubernetes_whitelist_name = "kubernetes-whitelist-middleware"
}

module "kubernetes_dashboard_dns" {
  source    = "../reusable-modules/dns-record"
  host_name = local.dashboard_host
  namespace = "kubernetes-dashboard"
}
resource "kubectl_manifest" "kubernetes_ingress" {
  yaml_body = <<-EOF
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: kubernetes-dashboard-ingress
  namespace: ${local.kubernetes_namespace}
spec:
  entryPoints:
  - websecure
  - web
  routes:
  - kind: Rule
    match: Host(`${local.dashboard_host}.tomondre.com`)
#    middlewares:
#    - name: ${local.kubernetes_whitelist_name}
#      namespace: ${local.kubernetes_namespace}
    services:
    - name: kubernetes-dashboard
      namespace: ${local.kubernetes_namespace}
      port: 443
      serversTransport: ${local.transport_name}
#  tls:
#    secretName: dashboard-secret
EOF
  depends_on = [kubectl_manifest.kubernetes_transport]
}

module "whitelist_middleware" {
  source = "../reusable-modules/whitelist-middleware"
  name   = local.kubernetes_whitelist_name
  whitelist_ips = var.whitelist_ips
  namespace = local.kubernetes_namespace
}